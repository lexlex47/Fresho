require './lib/pack'

class Selection
  
  attr_accessor :quantity,
                :total_price,
                :pack_quantity
  
  def initialize(quantity, total_price, pack_quantity)
    @quantity = quantity
    @total_price = total_price
    @pack_quantity = pack_quantity
  end
  
end