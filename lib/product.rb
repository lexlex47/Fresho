require './lib/pack'

class Product

  attr_accessor :name, :packs

  def initialize(name)
    @name = name
    @packs = []
  end

  def add_pack(quantity, price)
  end

end