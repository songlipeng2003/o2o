class CreateAppPayments < ActiveRecord::Migration[4.2]
  def change
    create_table :app_payments do |t|
      t.references :application, index: true
      t.references :payment, index: true
      t.integer :sort, default: 0

      t.timestamps
    end
  end
end
