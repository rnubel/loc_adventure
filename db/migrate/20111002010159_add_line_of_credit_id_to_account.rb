class AddLineOfCreditIdToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :line_of_credit_id, :integer
  end
end
