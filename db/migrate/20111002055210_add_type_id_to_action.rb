class AddTypeIdToAction < ActiveRecord::Migration
  def change
    add_column :actions, :type_id, :integer
  end
end
