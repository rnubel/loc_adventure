class Account < ActiveRecord::Base
  class Type < ActiveHash::Base
    include ActiveHash::Enum
    
    self.data = [
      { :id => 1,   :name => "Accounts Receivable" },
      { :id => 2,   :name => "Accounts Past Due" },
      { :id => 3,   :name => "Income" },
      { :id => 4,   :name => "Disbursement" },
      { :id => 5,   :name => "Customer" },
    ]

    enum_accessor :name

    def inspect
      "<Account::Type::#{self.name.underscore.upcase}>"
    end
  end

  ## Relations
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :account_type, :class_name => "Account::Type"
  belongs_to :line_of_credit
end
