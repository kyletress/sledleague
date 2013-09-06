class AddMembershipIdToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :membership_id, :integer
  end
end
