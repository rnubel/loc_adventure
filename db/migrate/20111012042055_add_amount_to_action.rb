class AddAmountToAction < ActiveRecord::Migration
  def change
    add_column :actions, :amount, :decimal
  end
end
