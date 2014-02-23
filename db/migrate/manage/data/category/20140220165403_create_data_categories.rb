class CreateDataCategories < ActiveRecord::Migration
  def change
    create_table :data_categories do |t|
      t.string :name
      t.string :description, limit: 3000
      t.integer :parent_id
      t.integer :editor_id
      t.integer :creator_id
      t.datetime :destroyed_at
      t.boolean :active, null: false, default: false
      t.timestamps
    end
  end
end
