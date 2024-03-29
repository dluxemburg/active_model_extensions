# ActiveModelExtensions

Some Extension::Extensions for your ActiveModel::Models

## Installation

Add this line to your application's Gemfile:

    gem 'active_model_extensions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_extensions

## Usage

### ActiveModelExtensions::InstanceValidatable

Include it in an Active Model class:

```ruby
class MyModel
  
  include ActiveModel::Model
  include ActiveModelExtensions::InstanceValidatable
  
  attr_accessor :my_field

end
```

Now instances of that class can be given instance-specific validators:

 ```ruby
  m = MyModel.new
  m.instance_validators << MyValidator
```

### ActiveModelExtensions::ValidationAlertable

Create a validator as a subclass of `ActiveModelExtensions::AlertingValidator` and `ActiveModelExtensions::ValidationAlertable` will be included into any model it is applied to.

Your `ActiveModelExtensions::AlertingValidator` can add to the model's `alerts` as well as `erros`. The `alerts` object is a `ActiveModel::Errors` instance (just like `errors`), but doesn't prevent the model instance from validating or saving. Useful for user messages about an update or save action.

For example, `MyAlertingValidator` will add an `alert` message or an `error` message depending on the severity of the situation with a model's `:field` value, only refusing to validate it if it's really bad: 

```ruby
class MyAlertingValidator < ActiveModelExtensions::AlertingValidator

  def validate(record)
    if record.field < 50 && record.field >= 25
      record.alerts.add(:field,"is is dangerously low, watch yourself")
    end
    if record.field < 25
      record.errors.add(:field, "is way too low, please increase")
    end
  end

end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
