require 'spec_helper'

describe Transaction do
  it "should have a credit account related" do
    Factory.create(:transaction).should respond_to :credit_account
  end

  it "should have a debit account related" do
    Factory.create(:transaction).should respond_to :debit_account
  end

  it "should have an amount" do
    Factory.create(:transaction).should respond_to :amount
  end

  it "should set its credit account" do
    t = Factory.create :transaction
    acc = Factory.create :account

    t.credit_account = acc
    t.save!
    t.reload

    t.credit_account.should == acc
  end 

  it "should set its debit account" do
    t = Factory.create :transaction
    acc = Factory.create :account

    t.credit_account = acc
    t.save!
    t.reload

    t.credit_account.should == acc
  end 

  it "should set its amount" do
    t = Factory.create :transaction

    t.amount = 150.0
    t.save!
    t.reload

    t.amount.should == 150.0
  end
end
