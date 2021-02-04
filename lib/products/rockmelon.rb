require './lib/product'

class Rockmelon < Product

  attr_accessor :name, :packs

  def initialize(name)
    super(name)
    @packs = []
    @unit_price = 0
  end

end