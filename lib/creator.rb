# Factory class
require './lib/products/watermelon'
require './lib/products/pineapple'
require './lib/products/rockmelon'

require './lib/line_items/watermelon_item'
require './lib/line_items/pineapple_item'
require './lib/line_items/rockmelon_item'

require './lib/constants'

class Creator

  # product instance generator
  def self.createProduct(type, name)
    Constants::PRODUCT_TYPES[type].new(name)
  end

  # line_item instance generator
  def self.createLineItem(product, quantity)
    Constants::LINE_ITEM_TYPES[product.name.to_sym].new(product,quantity)
  end

end