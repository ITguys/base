class AddCurrentAddressIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :current_address_id, :integer
  end
end
