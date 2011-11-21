class CreateLinesOfCredit < ActiveRecord::Migration
  def change
    create_table :lines_of_credit do |t|
      t.date :opened_on

      t.timestamps
    end
  end
end
