require 'rspec'
require 'spec_helper'
require './lib/product'

RSpec.describe Product do

  describe "#initialize" do
    it "should take one arguments" do
      expect(Product).to respond_to(:new).with(1).argument
    end
  end

  describe "#add_pack" do
    it "should take two arguments" do
      product = Product.new("example")
      expect(product).to respond_to(:add_pack).with(2).argument
    end
  end

end