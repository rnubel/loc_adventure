require 'spec_helper'

describe LineOfCredit do
  describe LineOfCredit::Status do
    it "should be instantiable" do
      status = LineOfCredit::Status.create(:name => "TestStatus")
      status.name.should == "TestStatus"
    end

    it "should be look-upable" do
      status = LineOfCredit::Status::OPEN
      status.name.should == "Open"
    end
  end

  it "should instantiate a new line of credit" do
    loc = Factory.create :line_of_credit

    loc.should_not be_nil
  end

  it "should set its credit limit" do
    loc = Factory.create :line_of_credit

    loc.credit_limit = 400

    loc.credit_limit.should == 400
  end

  it "should have many accounts" do
    loc = Factory.create :line_of_credit

    loc.should respond_to :accounts
  end

  it "should have a scope filter for accounts by type" do
    loc = Factory.create :line_of_credit

    account_one = Factory.create :account, :account_type => Account::Type::PRINCIPAL, :line_of_credit => loc
    account_two = Factory.create :account, :account_type => Account::Type::PRINCIPAL_PAST_DUE, :line_of_credit => loc

    loc.accounts.of_type(Account::Type::PRINCIPAL).should == [account_one]
  end

  it "should be able to be opened" do
    loc = Factory.create :line_of_credit
    loc.open

    loc.status.should == LineOfCredit::Status::OPEN
  end

  it "should create one of each account type when opened" do
    loc = Factory.create :line_of_credit
    loc.open

    loc.accounts.length.should == Account::Type.count
  end

  it "should be able to be closed" do
    loc = Factory.create :line_of_credit, :status => LineOfCredit::Status::OPEN
    loc.close

    loc.status.should == LineOfCredit::Status::CLOSED
  end

  it "should be able to be drawn on" do
    loc = Factory.create :line_of_credit, :status => LineOfCredit::Status::OPEN
    loc.open

    loc.draw(100)

    loc.actions.first.type.should == Action::Type::DRAW
    loc.actions.first.amount.should == 100.0

    loc.find_account(:principal).balance.should == 100.0
    loc.find_account(:customer).balance.should == -100.0
  end

  it "should lookup an associated account by code" do
    loc = Factory.create(:line_of_credit)
    account = Factory.create(:account, :account_type => Account::Type::CUSTOMER, :line_of_credit => loc)
    account2 = Factory.create(:account, :account_type => Account::Type::PRINCIPAL, :line_of_credit => loc)
    loc.save!
    loc.save!
    loc.reload
    loc.accounts.should_not be_empty

    loc.send('find_account', :customer).should == account
    loc.send('find_account', :principal).should == account2
  end
end
