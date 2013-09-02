class AddIndexToMatches < ActiveRecord::Migration
  def change
  	add_index :matches, :league_id
  	add_index :matches, :race_id
  end
end
