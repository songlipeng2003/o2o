class CreateBannerGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :banner_groups do |t|
      t.string :name
      t.string :key

      t.timestamps
    end

    change_table :banners do |t|
      t.references :banner_group
    end
  end
end
