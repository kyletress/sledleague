class AddCountryToAthletes < ActiveRecord::Migration
  def change
    add_column :athletes, :country, :string
  end
end
