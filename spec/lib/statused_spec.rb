require 'spec_helper'

class DummyClass
  include Statused

  attr_accessor :status
  def save!; end
end

describe Statused do
  it "should add a change_status method" do
    DummyClass.new.should respond_to :change_status
  end

  it "should change status" do
    test = DummyClass.new
    test.status = nil

    test.change_status(4)

    test.status.should == 4
  end

end
