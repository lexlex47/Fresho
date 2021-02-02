require './lib/line_item'
require './lib/watermelon'

class WatermelonItem < LineItem
  
  attr_accessor :product, :quantity

  def initialize(product, quantity)
    return nil unless (product.instance_of? Watermelon)
    super(product, quantity)
  end

end