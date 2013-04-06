module ActiveModelExtensions
  module ValidationAlertable

    extend ActiveSupport::Concern
    extend(ActiveModel::Callbacks)

    included do
      define_model_callbacks :run_validations
      before_run_validations :clear_alerts
    end

    def alerts
      @alerts ||= ActiveModel::Errors.new(self)
    end

    def has_alerts?
      clear_alerts
      valid?
      alerts.count > 0
    end

    private 

    def clear_alerts
      alerts.clear
    end

  end

  class AlertingValidator < ActiveModel::Validator
    def setup(klass)
      unless klass.method_defined?(:alerts)
        klass.send(:include,ValidationAlertable) 
      end
    end
  end
end



