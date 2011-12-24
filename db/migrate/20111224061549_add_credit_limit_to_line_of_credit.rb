class AddCreditLimitToLineOfCredit < ActiveRecord::Migration
  def change
    add_column :lines_of_credit, :credit_limit, :integer
  end
end
