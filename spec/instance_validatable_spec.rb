require "bundler"
Bundler.require(:default,:development)

class MyModel
  
  include ActiveModel::Model
  
  attr_accessor :field

end

class MyInstanceValidatedModel < MyModel
  
  include ActiveModelExtensions::InstanceValidatable

end

class MyValidator < ActiveModel::Validator
  
  def validate(record)
    unless record.field == 27
      record.errors.add(:field,'must not be blank')
    end
  end

end

describe "Active Model validation without extensions" do

    context "when preformed extenally" do

      it "fails to make the model invalid" do
        m = MyModel.new
        v = MyValidator.new
        v.validate(m)
        expect(m).to be_valid
      end

    end

    context "when added via singleton class" do
      
      it "fails to make the model invalid" do
        m = MyModel.new

        class << m
          validates_with MyValidator
        end

        expect(m).to be_valid

      end    

    end

    context "when added via '#validates_with'" do
      
      it "fails to make the model invalid" do
        m = MyModel.new

        m.validates_with MyValidator

        expect(m).to be_valid

      end    

    end

    context "when added by creating a new annonymous class" do
    
      it "does make the model invalid" do
        
        MyNewModel = Class.new(MyModel) do
          validates_with MyValidator
        end

        m = MyNewModel.new

        expect(m).to_not be_valid

      end    

    end

end


describe ActiveModelExtensions::InstanceValidatable do

  context "when used to add a validator" do
    
    it "should make the model invalid" do
      
      m = MyInstanceValidatedModel.new

      m.instance_validators << MyValidator

      expect(m).to_not be_valid

    end  

    it "but only when added" do
      
      m = MyInstanceValidatedModel.new

      expect(m).to be_valid

    end    

  end


end