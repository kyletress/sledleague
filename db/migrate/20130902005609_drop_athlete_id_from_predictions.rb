class DropAthleteIdFromPredictions < ActiveRecord::Migration
  def up
  	remove_column :predictions, :athlete_id
  	remove_column :predictions, :position
  end

  def down
  	add_column :predictions, :athlete_id, :integer
  	add_column :predictions, :position, :integer
  end
end
