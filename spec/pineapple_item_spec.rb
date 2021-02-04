require 'rspec'
require 'spec_helper'
require './lib/line_item'
require './lib/pineapple_item'

RSpec.describe PineappleItem do

  describe "#initialize" do
    it "should take two arguments" do
      expect(PineappleItem).to respond_to(:new).with(2).argument
    end

    it "should have one Pineapple instance" do
      pineapple = Creator.createProduct(:pineapple, "pineapple")
      pineappleItem = Creator.createLineItem(pineapple, 10)
      expect(pineappleItem.product).to be_an_instance_of(Pineapple)
    end
  end

end