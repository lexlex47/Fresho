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
      expect(@line_item.dividends.first.quantity).to eq(3)
      expect(@line_item.dividends.last.quantity).to eq(5)
    end
    it "should dividends has same value of product packs price" do
      expect(@line_item.dividends.first.price).to eq(6.99)
      expect(@line_item.dividends.last.price).to eq(8.99)
    end
  end

  describe "#caculate_selection" do
    context "watermelon have one pack(quantity is 3) and total quantity is 14" do
      before do
        @watermelon = Creator.createProduct(:watermelon, "watermelon")
        @watermelon.add_pack(3, 5)
        @line_item = Creator.createLineItem(@watermelon,14)
        @line_item.set_dividends
        @line_item.caculate_selection
      end
      it "should result_list be an array and not empty after caculate" do
        expect(@line_item.result_list).to be_an_instance_of(Array)
        expect(@line_item.result_list).not_to be_empty
      end
      it "should result with [quotient, 
                              remainder, 
                              current_pack_quantity,
                              pack_total_price]" do
        # 14 / 3 = 4..2 => [4,2,3,20(4*5)]
        expect(@line_item.result_list.first.first[0]).to eq(4)
        expect(@line_item.result_list.first.first[1]).to eq(2)
        expect(@line_item.result_list.first.first[2]).to eq(3)
        expect(@line_item.result_list.first.first[3]).to eq(20)
      end
    end
    context "watermelon have 3 packs(3pack / 5pack / 9pack) and total quantity is 14" do
      before do
        @watermelon = Creator.createProduct(:watermelon, "watermelon")
        @watermelon.add_pack(3, 5.95)
        @watermelon.add_pack(5, 9.95)
        @watermelon.add_pack(9, 16.99)
        @line_item = Creator.createLineItem(@watermelon,14)
        @line_item.set_dividends
        @line_item.caculate_selection
      end
      it "should result_list be an array and not empty after caculate" do
        expect(@line_item.result_list).to be_an_instance_of(Array)
        expect(@line_item.result_list).not_to be_empty
      end
      it "should result_list contain 3 solutions" do
        expect(@line_item.result_list.size).to eq(3)
      end
      it "should have 1st solution: 4*3pack + 2left" do
        # 14 / 3 = 4..2 => [4,2,3,23.8]
        expect(@line_item.result_list[0]).to eq([[4,2,3,23.8]])
      end
      it "should have 2nd solution: 2*5pack + 1*3pack + 1left" do
        # 14 / 5 = 2..4 => [2,4,5,19.9]
        # 4 / 3 = 1..1 => [1,1,3,5.95]
        expect(@line_item.result_list[1]).to eq([[2,4,5,19.9],[1,1,3,5.95]])
      end
      it "should have 3rd solution: 1*9pack + 1*5pack" do
        # 14 / 9 = 1..5 => [1,5,9,16.99]
        # 5 / 5 = 1 => [1,0,5,9.95]
        expect(@line_item.result_list[2]).to eq([[1,5,9,16.99],[1,0,5,9.95]])
      end
    end
  end

  describe "#find_next" do
    before do
      @watermelon = Creator.createProduct(:watermelon, "watermelon")
      @watermelon.add_pack(3, 2)
      @watermelon.add_pack(5, 3)
      @watermelon.add_pack(9, 4)
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
      it "should return array with 4 element: [quotient, 
                                               remainder, 
                                               current_pack_quantity, 
                                               pack_total_price]" do
        result = @line_item.find_next(3)
        expect(result).to eq([1,0,3,2])
      end
    end
    context "the value can be not divisible" do
      it "should return array[1] with the smaller remainder" do
        result = @line_item.find_next(7)
        expect(result).to eq([2,1,3,4])
        expect(result[1]).to eq(1)
        expect(result[2]).to eq(3)
      end
    end
  end

end