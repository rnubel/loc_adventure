class CreateBillingPeriods < ActiveRecord::Migration
  def change
    create_table :billing_periods do |t|
      t.integer :line_of_credit_id
      t.date :opened_on
      t.date :closed_on
      t.float :minimum_payment

      t.timestamps
    end
  end
end
