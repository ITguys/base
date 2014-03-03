class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :district_id
      t.integer :contact_id
      t.string :detail, limit: 512
      t.timestamps
    end
  end
end
