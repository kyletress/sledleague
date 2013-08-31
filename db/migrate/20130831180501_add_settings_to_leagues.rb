class AddSettingsToLeagues < ActiveRecord::Migration
  def change
  	add_column :leagues, :private, :boolean, default: false
  	add_column :leagues, :max_teams, :integer, :null => false, :default => 0
  	add_column :leagues, :max_matches, :integer, :null => false, :default => 0
  end
end
