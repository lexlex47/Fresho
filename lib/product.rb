require './lib/pack'

class Product

  attr_accessor :name, :packs

  def initialize(name)
    @name = name
    @packs = []
  end

  def add_pack(quantity, price)
    return unless (quantity.is_a? Numeric) && (price.is_a? Numeric)
    pack = Pack.new(quantity, price)
    @packs << pack
  end

end