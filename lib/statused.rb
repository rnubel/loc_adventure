# Including this class to ActiveRecord adds a Status enumeration
# and provides methods for dealing with statuses. Not really a 
# state machine.
module Statused
  extend ActiveSupport::Concern

  module ClassMethods


  end

  def change_status(new_status)
    self.status = new_status
    save!
  end
end
