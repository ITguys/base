class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :mobile_phone

      t.timestamps
    end
  end
end
