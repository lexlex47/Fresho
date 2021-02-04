require './lib/watermelon'
require './lib/watermelon_item'
require './lib/pineapple'
require './lib/pineapple_item'
require './lib/rockmelon'
require './lib/rockmelon_item'

class Creator

  PRODUCT_TYPES = {
    watermelon: Watermelon,
    pineapple: Pineapple,
    rockmelon: Rockmelon
  }

  LINE_ITEM_TYPES = {
    watermelon: WatermelonItem,
    pineapple: PineappleItem,
    rockmelon: RockmelonItem
  }

  def self.createProduct(type, name)
    PRODUCT_TYPES[type].new(name)
  end

  def self.createLineItem(product, quantity)
    LINE_ITEM_TYPES[product.name.to_sym].new(product,quantity)
  end

end