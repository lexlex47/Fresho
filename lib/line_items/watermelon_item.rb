require './lib/line_item'
require './lib/products/watermelon'

class WatermelonItem < LineItem
  
  attr_accessor :product, :quantity

  def initialize(product, quantity)
    return unless (product.instance_of? Watermelon) && (quantity.is_a? Numeric)
    super(product, quantity)
  end

end