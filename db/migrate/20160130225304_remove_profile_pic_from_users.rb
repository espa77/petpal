class RemoveProfilePicFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :profilePic
  end
end
