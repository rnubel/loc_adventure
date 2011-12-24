class Account < ActiveRecord::Base
  class Type < ActiveHash::Base
    include ActiveHash::Enum
    
    self.data = [
      { :id => 1,   :name => "Principal" },
      { :id => 2,   :name => "Interest" },
      { :id => 3,   :name => "Fees" },
      { :id => 4,   :name => "Principal Past Due" },
      { :id => 5,   :name => "Interest Past Due" },
      { :id => 6,   :name => "Fees Past Due" },
      { :id => 7,   :name => "Principal Disbursement" },
      { :id => 8,   :name => "Fees Income" },
      { :id => 9,   :name => "Interest Income" },
      { :id => 10,  :name => "Customer" },
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
