class ModifyFloatPrecision < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.change :lon, :decimal, :precision => 11, :scale => 8
      t.change :lat, :decimal, :precision => 11, :scale => 8
    end

    change_table :orders do |t|
      t.change :lon, :decimal, :precision => 11, :scale => 8
      t.change :lat, :decimal, :precision => 11, :scale => 8
    end
  end
end
