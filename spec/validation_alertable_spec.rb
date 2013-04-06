require "bundler"
Bundler.require(:default,:development)

class MyAlertingValidator < ActiveModelExtensions::AlertingValidator

  def validate(record)
    unless record.field == 72
      record.alerts.add(:field,"is #{record.field} instead of 72, watch yourself")
    end
  end

end

class MyAlertingModel < MyModel

  validates_with MyAlertingValidator

end



describe ActiveModelExtensions::ValidationAlertable do

  it "should add an alert when appropriate, but not make the model invalid" do

    m = MyAlertingModel.new(field:71)

    expect(m).to be_valid 
    expect(m).to have_alerts    
    expect(m.alerts.count).to eq(1)
    expect(m.alerts.get(:field)).to eq(["is 71 instead of 72, watch yourself"])
    expect(m.alerts.full_messages).to eq(["Field is 71 instead of 72, watch yourself"])

  end

  it "should not add an alert when validator doesn't need to" do

    m = MyAlertingModel.new(field:72)

    expect(m).to be_valid 
    expect(m).to_not have_alerts    

  end


end