class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :account_type_id
      t.float :balance

      t.timestamps
    end
  end
end
