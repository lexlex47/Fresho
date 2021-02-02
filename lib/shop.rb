require 'singleton'
require './lib/creator'

class Shop

  include Singleton

  attr_accessor :watermelon
  attr_accessor :watermelonitem

  def initialize
    "is a Singleton"
  end

  def load_products
    @watermelon = Creator.createProduct(:watermelon, "watermelon")
    @watermelon.add_pack(3, 6.99)
  end

  def process_order(order)
    processor = order.strip.split(' ')
  end

  def create_invoice
    
  end

end