class AddStatusIdToLineOfCredit < ActiveRecord::Migration
  def change
    add_column :lines_of_credit, :status_id, :int
  end
end
