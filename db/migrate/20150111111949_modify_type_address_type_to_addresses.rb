class ModifyTypeAddressTypeToAddresses < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.rename :type, :address_type
    end
  end
end
