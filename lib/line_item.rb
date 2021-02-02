class LineItem

  attr_accessor :product, :quantity

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end

end