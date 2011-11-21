require 'spec_helper'

describe Action do
  it "should instantiate" do
    action = Factory.create(:action)
    
    action.should_not be_nil
  end 

  it "should have a type" do
    action = Factory.create(:action)

    action.should respond_to(:type)
  end

  it "should set its type" do
    action = Factory.create(:action, :type => Action::Type::DRAW)

    action.type.should == Action::Type::DRAW
  end

  it "should set its status" do
    action = Factory.create(:action, :status => Action::Status::SCHEDULED)

    action.status.should == Action::Status::SCHEDULED
  end

  it "should have an amount" do
    action = Factory.create(:action, :amount => 100.0)

    action.amount.should == 100.0
  end

  it "should belong to a line of credit" do
    action = Factory.create(:action)
    loc = Factory.create(:line_of_credit)
    action.line_of_credit = loc
    action.save!

    action.line_of_credit.should == loc
  end

  it "should be created with an effective_on date" do
    action = Factory.create(:action, :effective_on => Date.today + 10.days)
    
    action.effective_on.should == Date.today + 10.days
  end

  it "should be effectable" do
    action = Factory.create(:action,
               :type => Action::Type::DRAW,
               :status => Action::Status::SCHEDULED,
               :effective_on => Date.today)

    lambda { action.effect! }.should_not raise_error
  end

  it "should change its status to effected when effected" do
    action = Factory.create(:action,
               :type => Action::Type::DRAW,
               :status => Action::Status::SCHEDULED,
               :effective_on => Date.today)
    action.effect!

    action.status.should == Action::Status::EFFECTED
  end

  it "should be related to transactions" do
    Factory.create(:action).should respond_to :transactions
  end

  describe Action::Type::DRAW do
    before(:each) do
      @action = Factory.create(:action,
                 :type => Action::Type::DRAW,
                 :status => Action::Status::SCHEDULED,
                 :effective_on => Date.today,
                 :amount => 100.0)
      account1 = Factory.create(:account, :account_type => Account::Type::CUSTOMER)
      account2 = Factory.create(:account, :account_type => Account::Type::ACCOUNTS_RECEIVABLE)
      @action.line_of_credit.expects('find_account').with(:customer).returns(account1)
      @action.line_of_credit.expects('find_account').with(:accounts_receivable).returns(account2)
      @action.effect!
    end

    it "should create a transaction from customer to receivable when effected" do
      @action.transactions.all? { |tr|
        tr.debit_account.account_type.should == Account::Type::CUSTOMER
        tr.credit_account.account_type.should == Account::Type::ACCOUNTS_RECEIVABLE
        tr.amount.should == 100.0
      }.should == true
    end

    it "should increase the line of credit's balance" do
      false.should be_true 
    end
  end

end
