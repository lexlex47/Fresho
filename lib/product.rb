require './lib/pack'

class Product

  attr_accessor :name, :packs, :unit_price

  def initialize(name)
    @name = name
    @packs = []
    @unit_price = 0
  end

  def add_pack(quantity, price)
    return unless (quantity.is_a? Numeric) && (price.is_a? Numeric)
    pack = Pack.new(quantity, price)
    @packs << pack
    update_unit_price()
  end

  def update_unit_price
    return if @packs.empty?
    lowest = @packs.min_by{|pack| pack.quantity}
    @unit_price = (lowest.price / lowest.quantity).to_f.round(2)
  end

end