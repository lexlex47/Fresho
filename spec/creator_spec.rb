require 'rspec'
require 'spec_helper'
require './lib/creator'
require './lib/watermelon'

RSpec.describe Creator do

  describe "#createProduct" do
    
    it "should take two arguments" do
      expect(Creator).to respond_to(:createProduct).with(2).argument
    end

    context "if type is Watermelon" do
      it "should create a watermelon object" do
        watermelon = Creator.createProduct(:watermelon, "watermelon")
        expect(watermelon).to be_an_instance_of(Watermelon)
      end
    end

  end

  describe "#createLineItem" do
    
    it "should take two arguments" do
      expect(Creator).to respond_to(:createLineItem).with(2).argument
    end

    context "if product is Watermelon" do
      it "should create a watermelonItem object" do
        watermelon = Creator.createProduct(:watermelon, "watermelon")
        watermelonItem = Creator.createLineItem(watermelon, 10)
        expect(watermelonItem).to be_an_instance_of(WatermelonItem)
      end
    end
  end

end