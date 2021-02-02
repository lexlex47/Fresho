require './lib/product'

class WaterMelon < Product

  attr_accessor :name, :packs

  def initialize(name)
    super(name)
    @packs = []
  end

  def add_pack(quantity, price)
    return unless (quantity.is_a? Numeric) && (price.is_a? Numeric)
    pack = Pack.new(quantity, price)
    @packs << pack
  end

end