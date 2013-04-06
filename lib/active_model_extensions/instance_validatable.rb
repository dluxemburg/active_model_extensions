module ActiveModelExtensions
  module InstanceValidatable
    
    extend ActiveSupport::Concern

    included do
      validate :instance_validations
    end

    def instance_validators
      @instance_validators ||= []
    end

    def instance_validations
      validates_with *@instance_validators
    end

  end
end
