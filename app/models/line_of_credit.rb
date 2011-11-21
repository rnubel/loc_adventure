class LineOfCredit < ActiveRecord::Base
  include Statused

  # Inner class to define a Line of Credit's current status.
  class Status < ActiveHash::Base
    include ActiveHash::Enum
    
    self.data = [
      { :id => 1,   :name => "Open" },
      { :id => 2,   :name => "Called Due" },
      { :id => 3,   :name => "Closed" },
      { :id => 4,   :name => "Withdrawn" },
    ]

    enum_accessor :name
  end


  extend ActiveHash::Associations::ActiveRecordExtensions


  ## Relations

  # Each LOC has accounts associated with it, representing how much the customer
  # owes, has out, has past due, etc. These should only be used to distinguish
  # money for operational purposes and do not represent accounting state.
  has_many :accounts do
    # Filter accounts by a given type.
    def of_type(type)
      find(:all, :conditions => {:account_type_id => type.id})
    end

    def find_by_code(code)
      type = Account::Type.find_by_name(code.to_s.titleize)
      find(:first, :conditions => {:account_type_id => type.id})
    end
  end

  belongs_to_active_hash :status, :class_name => "LineOfCredit::Status"
  has_many :actions


  ## Public methods (interface)

  # Open the line of credit.
  def open
    change_status(LineOfCredit::Status::OPEN)

    open_accounts!
  end 

  # Draw money from the line of credit (giving it to the customer).
  def draw(amount, effective_on = Date.today)
    draw_action = self.actions.create(
      :type => Action::Type::DRAW, 
      :status => Action::Status::SCHEDULED,
      :effective_on => effective_on, 
      :amount => amount)
    save!
  end

  # Pay money off of the account's balance (taking it from the customer).
  def pay_off(amount)
  end

  # Call the account due. Essentially closed, but could be cured.
  def call_due
  end

  # Close the account.
  def close
    change_status(LineOfCredit::Status::CLOSED)
  end


  ## Accessor wrappers
  def find_account(account_code)
    self.accounts.find_by_code(account_code)
  end

private
  # Create one of each account type.
  def open_accounts!
    Account::Type.find(:all).each do |type|
      Account.create(:line_of_credit => self, :account_type => type, :balance => 0.00)
    end
  end

 
end
