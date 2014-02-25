class CreateDataCategories < ActiveRecord::Migration
  def change
    create_table :data_categories do |t|
      t.string :name
      t.integer :parent_id, null: false, default: 0
      t.string :description
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
