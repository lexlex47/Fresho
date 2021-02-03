require 'rspec'
require 'spec_helper'
require './lib/line_item'

RSpec.describe LineItem do

  describe "#initialize" do
    it "should take two arguments" do
      expect(LineItem).to respond_to(:new).with(2).argument
    end
  end

  describe "#set_dividends" do
    before do
      @watermelon = Creator.createProduct(:watermelon, "watermelon")
      @watermelon.add_pack(3, 6.99)
      @watermelon.add_pack(5, 8.99)
      @line_item = Creator.createLineItem(@watermelon,10)
      @line_item.set_dividends
    end
    it "should dividends be an array" do
      expect(@line_item.dividends).to be_an_instance_of(Array)
    end
    it "should dividends has same length of product packs" do
      expect(@line_item.dividends.length).to eq(@watermelon.packs.length)
    end
    it "should dividends has same value of product packs quantity" do
      expect(@line_item.dividends.first).to eq(3)
      expect(@line_item.dividends.last).to eq(5)
    end
  end

  describe "#find_next" do
    before do
      @watermelon = Creator.createProduct(:watermelon, "watermelon")
      @watermelon.add_pack(3, 0)
      @watermelon.add_pack(5, 0)
      @watermelon.add_pack(9, 0)
      @line_item = Creator.createLineItem(@watermelon,14)
      @line_item.set_dividends
    end
    it "should take one argument" do
      expect(@line_item).to respond_to(:find_next).with(1).argument
    end
    it "should return empty if argument is less than all dividends" do
      result = @line_item.find_next(2)
      expect(result).to be_empty
    end
    context "the value can be divisible" do
      it "should return array[1] is 0" do
        result = @line_item.find_next(5)
        expect(result[1]).to eq(0)
      end
      it "should return array with 3 element and last one is the dividend number" do
        result = @line_item.find_next(3)
        expect(result).to eq([1,0,3])
        expect(result.last).to eq(3)
      end
    end
    context "the value can be not divisible" do
      it "should return array[1] with the smaller remainder" do
        result = @line_item.find_next(7)
        expect(result).to eq([2,1,3])
        expect(result[1]).to eq(1)
        expect(result.last).to eq(3)
      end
    end
  end

end