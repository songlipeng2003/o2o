class AddWashMachineProdcut < ActiveRecord::Migration
  def up
    execute "INSERT INTO `products` (`id`, `name`, `description`, `price`, `created_at`, `updated_at`, `market_price`, `image`, `product_type_id`, `category_id`, `suv_price`, `province_id`, `city_id`)
      VALUES
        (9, '洗车机', '洗车机', 10, now(), now(), 10, NULL, NULL, NULL, NULL, 916, 917);"
  end

  def down
  end
end
