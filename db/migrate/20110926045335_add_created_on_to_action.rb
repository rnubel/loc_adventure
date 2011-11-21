class AddCreatedOnToAction < ActiveRecord::Migration
  def change
    add_column :actions, :created_on, :date
  end
end
