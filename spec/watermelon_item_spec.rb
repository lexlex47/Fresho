require 'rspec'
require 'spec_helper'
require './lib/line_item'
require './lib/watermelon_item'

RSpec.describe WatermelonItem do

  describe "#initialize" do
    it "should take two arguments" do
      expect(WatermelonItem).to respond_to(:new).with(2).argument
    end

    it "should have one Watermelon instance" do
      watermelon = Creator.createProduct(:watermelon, "watermelon")
      watermelonItem = Creator.createLineItem(watermelon, 10)
      expect(watermelonItem.product).to be_an_instance_of(Watermelon)
    end
  end

end