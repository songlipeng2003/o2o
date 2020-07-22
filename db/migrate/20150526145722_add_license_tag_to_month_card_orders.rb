class AddLicenseTagToMonthCardOrders < ActiveRecord::Migration[4.2]
  def change
    change_table :month_card_orders do |t|
      t.string :license_tag
    end
  end
end
