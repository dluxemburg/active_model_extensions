require "bundler"
Bundler.require(:default,:development)

class MyModel
  
  include ActiveModel::Model
  include ActiveModelExtensions::ActiveStateful
  
  active_state(:small,:large)

end

describe ActiveModelExtensions::ActiveStateful do

  it "should only allow valid states" do
    m = MyModel.new
    
    m.state = :small
    m.save
    expect(m).to be_valid


    m.state = :medium
    expect(m).to be_changed
    expect(m).to_not be_valid
  end

end