class AddIndexToPredictions < ActiveRecord::Migration
  def change
  	add_index :predictions, :user_id
  	add_index :predictions, :match_id
  end
end
