require 'singleton'
require './lib/creator'
require './lib/invoice'

class Shop

  include Singleton

  attr_accessor :line_items, :products_type, :items_type
  attr_accessor :invoice

  def initialize
    "is a Singleton"
    @products_type = {
      "watermelon" => @watermelon,
      "pineapple" => @pineapple,
      "rockmelon" => @rockmelon
    }
    @items_type = {
      "watermelon" => @watermelonitem,
      "pineapple" => @pineappleitem,
      "rockmelon" => @rockmelonitem
    }
    @line_items = []
  end

  def load_products
    @products_type["watermelon"] = Creator.createProduct(:watermelon, "watermelon")
    @products_type["watermelon"].add_pack(3, 6.99)
    @products_type["watermelon"].add_pack(5, 8.99)

    @products_type["pineapple"] = Creator.createProduct(:pineapple, "pineapple")
    @products_type["pineapple"].add_pack(2, 9.95)
    @products_type["pineapple"].add_pack(5, 16.95)
    @products_type["pineapple"].add_pack(8, 24.95)

    @products_type["rockmelon"] = Creator.createProduct(:rockmelon, "rockmelon")
    @products_type["rockmelon"].add_pack(3, 5.95)
    @products_type["rockmelon"].add_pack(5, 9.95)
    @products_type["rockmelon"].add_pack(9, 16.99)
  end

  def process_order(order)
    data = order.strip.split(' ')
    return unless (data.size == 2)
    name = data.first.downcase
    return if @products_type[name].nil?
    quantity = is_numerical(data.last)
    return unless quantity && quantity > 0
    if @items_type[name].nil?
      @items_type[name] = Creator.createLineItem(@products_type[name],quantity)
      @line_items << @items_type[name]
    else
      @items_type[name].update_quantity(quantity)
    end
  end

  def create_invoice
    @invoice = Invoice.new(@line_items)
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