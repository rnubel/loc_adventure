class AddStatusIdToAction < ActiveRecord::Migration
  def change
    add_column :actions, :status_id, :integer
  end
end
