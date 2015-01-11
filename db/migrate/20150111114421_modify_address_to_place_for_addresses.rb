class ModifyAddressToPlaceForAddresses < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.rename :address, :place
    end
  end
end
