require "spec_helper"

describe Account do
  describe Account::Type do
    it "should act like a lookup table" do
      # Note: dependent on actual values in AccountType.
      Account::Type::PRINCIPAL.should == Account::Type.new(:id => 1, :name => "Principal")
      Account::Type::PRINCIPAL_PAST_DUE.should == Account::Type.new(:id => 4, :name => "Principal Past Due")
    end
  end

  it "should instantiate with no params" do
    account = Factory.create(:account)

    account.should_not be_nil
  end

  it "should have an account type" do
    account = Factory.create(:account)

    account.should respond_to(:account_type)
  end

  it "should set an account type" do
    account = Factory.create(:account)
    account.account_type = Account::Type.create(:name => "Test")
    account.save

    account.account_type.name.should == "Test" 
  end

  it "should be able to be found by account type" do
    custom_type = Account::Type.create(:id => 6, :name => "Test2")
    account = Factory.create(:account, :account_type => custom_type)
    Account.find(:all, :conditions => {:account_type_id => custom_type.id})
  end

  it "should allow its balance to be set and loaded" do
    account = Factory.create(:account)
    account.balance = 100.0
    account.save
    account.reload

    account.balance.should == 100.0
  end

  it "should belong to a line of credit" do
    account = Factory.create(:account)

    account.should respond_to(:line_of_credit)
  end

  it "should set and restore its line of credit" do
    loc = Factory.create(:line_of_credit)
    account = Factory.create(:account, :line_of_credit => loc)
    account.save
    account.reload

    account.line_of_credit.should == loc
  end
end
