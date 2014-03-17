class AddTotalPointsToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :total_points, :integer
  end
end
