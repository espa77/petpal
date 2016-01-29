class AddNameGenderBirthdaySpeciesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
    add_column :users, :species, :string
    add_column :users, :profilePic, :string
  end
end
