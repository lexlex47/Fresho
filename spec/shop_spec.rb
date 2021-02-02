require 'rspec'
require 'spec_helper'
require './lib/shop'

RSpec.describe Shop do

  let(:shop) {Shop.instance}
  let(:watermelon) {shop.instance_variable_get(:@watermelon)}
  let(:watermelonitem) {shop.instance_variable_get(:@watermelonitem)}

  before do
    Singleton.__init__(Shop)
  end

  describe "#initialize" do
    it "should Shop is a singleton instance" do
      expect(Shop.instance) == "is a Singleton"
    end
  end

  describe "#load_products" do
    it "should create a watermelon instance" do
      shop.load_products
      expect(watermelon).to be_an_instance_of(Watermelon)
    end
  end

  describe "#process_order" do
    before do
      shop.load_products
    end
    context "if input length is not equal to 2" do
      input_text = "Watermelon 10 10"
      it "should return void" do
        expect(shop.process_order(input_text)).to eq(nil)
      end
    end
    context "if input last is not a valid numeric" do
      input_text = "Watermelon aaa"
      it "should return void" do
        expect(shop.process_order(input_text)).to eq(nil)
      end
    end
    context "if input is valid argument: Watermelon 10" do
      before do
        input_text = "Watermelon 10"
        shop.process_order(input_text)
      end
      it "should create a watermelonitem instance if there watermelonitem instance is nil" do
        expect(watermelonitem).to be_an_instance_of(WatermelonItem)
      end
      it "should only increase quantity if watermelonitem instance already exists" do
        input_text = "Watermelon 5"
        shop.process_order(input_text)
        expect(watermelonitem.quantity).to eq(15)
      end
    end
  end


end