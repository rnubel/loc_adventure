class AddEffectiveOnToAction < ActiveRecord::Migration
  def change
    add_column :actions, :effective_on, :date
  end
end
