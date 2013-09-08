class AddCompletedToRaces < ActiveRecord::Migration
  def change
    add_column :races, :completed, :boolean, default: false
  end
end
