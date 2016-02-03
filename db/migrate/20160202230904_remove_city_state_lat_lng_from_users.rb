class RemoveCityStateLatLngFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :lat
    remove_column :users, :lng
  end
end
