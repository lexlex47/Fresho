require 'rspec'
require 'spec_helper'
require './lib/line_item'
require './lib/rockmelon_item'

RSpec.describe RockmelonItem do

  describe "#initialize" do
    it "should take two arguments" do
      expect(RockmelonItem).to respond_to(:new).with(2).argument
    end

    it "should have one Watermelon instance" do
      rockmelon = Creator.createProduct(:rockmelon, "rockmelon")
      rockmelonItem = Creator.createLineItem(rockmelon, 10)
      expect(rockmelonItem.product).to be_an_instance_of(Rockmelon)
    end
  end

end