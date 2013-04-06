require 'forwardable'
require 'pry'

module ActiveModelExtensions
  module ActiveStateful

    extend ActiveSupport::Concern
    extend ActiveModel::Callbacks

    included do
      include ActiveModel::Dirty

      define_attribute_methods :state
      define_method(:state){ @state }
      define_method(:state=) do |val|
        state_will_change! unless val == @state 
        @state = val
      end

      unless method_defined?(:save)
        define_method(:save){ 
            @previously_changed = changes
            @changed_attributes.clear
         }
      end

    end

    module ClassMethods

      def active_state(*args,&block)
        options = args.extract_options!
        validator_factory = ValidatorFactory.new(args,options)
        yield(validator_factory) if block_given?
        validates_with validator_factory.validator
      end

    end

    ValidatorFactory = Struct.new(:states,:options) do
    
      def validator
        klass = Class.new(ActiveStateful::Validator)
        klass.allowed_values = states
        klass
      end
      
    end

    class Validator < ActiveModel::Validator

      class << self
        attr_accessor :allowed_values
      end

      extend Forwardable

      def_delegators :klass, :allowed_values

      def klass
        self.class
      end

      def validate(record,context=nil)
        @record = record
        unless allowed_values.include?(record.state)
          record.errors.add(:state,"cannot be '#{record.state}'")
        end
      end

      def is_transition?
        @record.state_changed?
      end

      def transition
        [@record.state_was,@record.state]
      end

    end

  end
end
