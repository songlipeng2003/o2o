class AddApplicationToModels < ActiveRecord::Migration[4.2]
  def change
    change_table :orders do |t|
      t.references :application
    end

    change_table :recharges do |t|
      t.references :application
    end

    change_table :cars do |t|
      t.references :application
    end

    change_table :upload_files do |t|
      t.references :application
    end

    change_table :evaluations do |t|
      t.references :application
    end
  end
end
