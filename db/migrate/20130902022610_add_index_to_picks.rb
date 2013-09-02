class AddIndexToPicks < ActiveRecord::Migration
  def change
  	add_index :picks, :prediction_id
  end
end
