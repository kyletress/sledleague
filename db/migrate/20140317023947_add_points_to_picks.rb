class AddPointsToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :points, :integer
  end
end
