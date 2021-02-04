require 'singleton'
require './lib/creator'
require './lib/invoice'

class Shop

  include Singleton

  attr_accessor :watermelon, :pineapple, :rockmelon
  attr_accessor :watermelonitem, :pineappleitem, :rockmelonitem
  attr_accessor :invoice

  def initialize
    "is a Singleton"
  end

  def load_products
    @watermelon = Creator.createProduct(:watermelon, "watermelon")
    @watermelon.add_pack(3, 6.99)
    @watermelon.add_pack(5, 8.99)

    @pineapple = Creator.createProduct(:pineapple, "pineapple")
    @pineapple.add_pack(2, 9.95)
    @pineapple.add_pack(5, 16.95)
    @pineapple.add_pack(8, 24.95)

    @rockmelon = Creator.createProduct(:rockmelon, "rockmelon")
    @rockmelon.add_pack(3, 5.95)
    @rockmelon.add_pack(5, 9.95)
    @rockmelon.add_pack(9, 16.99)
  end

  def process_order(order)
    data = order.strip.split(' ')
    return unless (data.size == 2)
    name = data.first.downcase
    quantity = is_numerical(data.last)
    return unless quantity && quantity > 0

    case name
    when "watermelons"
      if @watermelonitem.nil?
        @watermelonitem = Creator.createLineItem(@watermelon,quantity)
      else
        @watermelonitem.update_quantity(quantity)
      end
    when "pineapples"
      if @pineappleitem.nil?
        @pineappleitem = Creator.createLineItem(@pineapple,quantity)
      else 
        @pineappleitem.update_quantity(quantity)
      end
    when "rockmelons"
      if @rockmelonitem.nil?
        @rockmelonitem = Creator.createLineItem(@rockmelon,quantity)
      else 
        @rockmelonitem.update_quantity(quantity)
      end
    end
  end

  def create_invoice
    @invoice = Invoice.new([@watermelonitem,@pineappleitem,@rockmelonitem])
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