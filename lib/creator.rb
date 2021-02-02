require './lib/watermelon'
require './lib/watermelon_item'

class Creator

  PRODUCT_TYPES = {
    watermelon: Watermelon
  }

  LINE_ITEM_TYPES = {
    watermelon: WatermelonItem
  }

  def self.createProduct(type, name)
    PRODUCT_TYPES[type].new(name)
  end

  def self.createLineItem(product, quantity)
    LINE_ITEM_TYPES[product.name.to_sym].new(product,quantity)
  end

end