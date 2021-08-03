class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true
      t.string :title
      t.integer :condition
      t.integer :price
      t.text :description
      t.boolean :sold, null:false, default: false

      t.timestamps
    end
  end
end
