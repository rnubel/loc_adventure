class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :action_id
      t.float :amount
      t.integer :debit_account_id
      t.integer :credit_account_id

      t.timestamps
    end
  end
end
