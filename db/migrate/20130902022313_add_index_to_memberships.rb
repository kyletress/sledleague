class AddIndexToMemberships < ActiveRecord::Migration
  def change
  	add_index :memberships, :user_id
  	add_index :memberships, :league_id
  end
end
