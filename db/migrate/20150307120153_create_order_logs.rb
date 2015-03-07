class CreateOrderLogs < ActiveRecord::Migration
  def change
    create_table :order_logs do |t|
      t.references :order
      t.references :user, polymorphic: true
      t.string :state
      t.string :changed_state
      t.string :remark
      t.datetime :created_at
    end
  end
end
