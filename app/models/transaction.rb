class Transaction < ActiveRecord::Base
  belongs_to :debit_account,  :class_name => "Account"
  belongs_to :credit_account, :class_name => "Account"

  attr_accessible :debit_account
  attr_accessible :credit_account
  attr_accessible :amount
end
