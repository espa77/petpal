class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :attachment
      t.string :title
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
