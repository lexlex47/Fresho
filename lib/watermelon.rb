require 'product'

class WaterMelon < Product

  attr_accessor :name, :packs

  def initialize()
    @name = "watermelon"
    @packs = nil
  end

  def add_pack(quantity, price)
    pack = Pack.new(quantity, price)
    @packs << pack
  end

end