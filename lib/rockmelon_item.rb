require './lib/line_item'
require './lib/rockmelon'

class RockmelonItem < LineItem
  
  attr_accessor :product, :quantity

  def initialize(product, quantity)
    return unless (product.instance_of? Rockmelon) && (quantity.is_a? Numeric)
    super(product, quantity)
  end

end