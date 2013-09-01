class RenameMembershipIdColumn < ActiveRecord::Migration
  def change
  	rename_column :predictions, :membership_id, :user_id
  end
end
