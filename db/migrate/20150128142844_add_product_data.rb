class AddProductData < ActiveRecord::Migration
  def change
    Product.create({
      name: '标准洗车-轿车',
      price: 15,
      product_type: Product::PRODUCT_TYPE_WASH,
      description: '标准洗车-轿车'
    })
    Product.create({
      name: '标准洗车-SUV',
      price: 20,
      product_type: Product::PRODUCT_TYPE_WASH,
      description: '标准洗车-SUV'
    })
    Product.create({
      name: '标准打蜡-轿车',
      price: 25,
      product_type: Product::PRODUCT_TYPE_WAX,
      description: '标准打蜡-轿车'
    })
    Product.create({
      name: '标准打蜡-SUV',
      price: 30,
      product_type: Product::PRODUCT_TYPE_WAX,
      description: '标准打蜡-SUV'
    })
  end
end
