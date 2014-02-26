class AddedSomeColumnsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :gender, :string
    add_column :contacts, :age, :integer
    add_column :contacts, :birthday, :date
  end
end
