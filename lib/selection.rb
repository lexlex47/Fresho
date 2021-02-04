# Selection class
require './lib/pack'

class Selection
  
  attr_accessor :quantity,
                :total_price,
                :pack_quantity
  
  def initialize(quantity, total_price, pack_quantity)
    @quantity = quantity
    @total_price = total_price.to_f.round(2)
    @pack_quantity = pack_quantity
  end
  
end