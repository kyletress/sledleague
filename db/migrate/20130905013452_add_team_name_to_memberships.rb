class AddTeamNameToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :team, :string
  end
end
