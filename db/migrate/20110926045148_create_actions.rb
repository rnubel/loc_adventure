class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :line_of_credit_id
      t.integer :billing_period_id

      t.timestamps
    end
  end
end
