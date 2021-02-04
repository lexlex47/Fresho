require './lib/line_item'
require './lib/products/pineapple'

class PineappleItem < LineItem
  
  attr_accessor :product, :quantity

  def initialize(product, quantity)
    return unless (product.instance_of? Pineapple) && (quantity.is_a? Numeric)
    super(product, quantity)
  end

end