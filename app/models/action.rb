class Action < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  include Statused

  class Type < ActiveYaml::Base
    include ActiveHash::Enum
    
    set_root_path Rails.root + "config"
    set_filename "actions"

    enum_accessor :name
  end

  class Status < ActiveHash::Base
    include ActiveHash::Enum
    
    self.data = [
      { :id => 1,   :name => "Scheduled" },
      { :id => 2,   :name => "Effected" },
      { :id => 3,   :name => "Cancelled" },
      { :id => 4,   :name => "Returned" },
    ]

    enum_accessor :name
  end



  ## Relations
  belongs_to :line_of_credit
  has_many :transactions
  belongs_to_active_hash :type, :class_name => "Action::Type"
  belongs_to_active_hash :status, :class_name => "Action::Status"

  attr_accessible :type
  attr_accessible :status
  attr_accessible :amount

  ## Public methods

  # Effect this action.
  def effect!
    raise :not_effectable unless effectable?

    # Carry out the associated transactions.
    self.type.transactions.each do |debit, credit|
      # TODO: Worry about how waterfalling should work.
      debit_account = line_of_credit.find_account(debit)
      credit_account = line_of_credit.find_account(credit)
   
      # We create the transaction as an audit trail, in case we need
      # to recompute balances later. TODO: wrap in transaction
      transactions.create(:debit_account => debit_account,
                          :credit_account => credit_account,
                          :amount => amount)
      
      debit_account.balance -= amount
      credit_account.balance += amount
      debit_account.save!
      credit_account.save!
      # TODO: check balances
    end
    
    # Update our status.
    change_status Action::Status::EFFECTED
  end

  # Cancel this action if not already effected.
  def cancel!
    raise :not_cancellable unless cancellable?

    # Update our status.
    change_status Action::Status::CANCELLED
  end

  # Mark this action as having been returned.
  def return!
    raise :not_returnable unless returnable?

    # Update our status.
    change_status Action::Status::RETURNED
  end


  def effectable?
    self.status == Action::Status::SCHEDULED
  end

  def cancellable?
    self.status == Action::Status::SCHEDULED
  end

  def returnable?
    self.status == Action::Status::EFFECTED
  end

end
