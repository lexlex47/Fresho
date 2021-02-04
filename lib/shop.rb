require 'singleton'
require './lib/creator'
require './lib/invoice'

class Shop

  include Singleton

  attr_accessor :watermelon
  attr_accessor :watermelonitem
  attr_accessor :invoice

  def initialize
    "is a Singleton"
  end

  def load_products
    @watermelon = Creator.createProduct(:watermelon, "watermelon")
    @watermelon.add_pack(3, 6.99)
    @watermelon.add_pack(5, 8.99)
  end

  def process_order(order)
    data = order.strip.split(' ')
    return unless (data.size == 2)
    name = data.first.downcase
    quantity = is_numerical(data.last)
    return unless quantity

    case name
    when "watermelon"
      if @watermelonitem.nil?
        @watermelonitem = Creator.createLineItem(@watermelon,quantity)
      else 
        @watermelonitem.quantity += quantity
      end
    end
  end

  def create_invoice
    @invoice = Invoice.new([@watermelonitem])
  end

  def print_invoice
    @invoice.output
  end

  private

  def is_numerical(arg)
    return nil if (arg.to_s.match(/[^-?\d+]/)) || (arg == '')
    arg.to_i
  end

end