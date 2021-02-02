require 'singleton'
require './lib/creator'

class Shop

  include Singleton

  attr_accessor :watermelon

  def initialize
    "is a Singleton"
  end

  def load_products
    @watermelon = Creator.create(:watermelon, "watermelon")
    @watermelon.add_pack(3, 6.99)
  end

  def process_order(order)
    
  end

  def create_invoice
    
  end

end