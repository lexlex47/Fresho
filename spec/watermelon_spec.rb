require 'rspec'
require 'spec_helper'
require './lib/product'
require './lib/watermelon'
require './lib/pack'

RSpec.describe Watermelon do

  let(:watermelon) {Watermelon.new("watermelon")}

  describe "#initialize" do
    it "should take one arguments" do
      expect(Watermelon).to respond_to(:new).with(1).argument
    end
  end

  describe "#add_pack" do
    it "should take two arguments" do
      expect(watermelon).to respond_to(:add_pack).with(2).argument
    end

    context "if one of arguments are not numeric" do
      it "should return void" do
        expect(watermelon.add_pack("a",2)).to eq(nil)
      end
    end

    context "if all arguments are valid" do
      before do
        watermelon.add_pack(3, 6.99)
      end

      it "should change packs[]" do
        expect(watermelon.packs.length).to eq(1)
      end
      it "should create a Pack instance" do
        expect(watermelon.packs[0]).to be_an_instance_of(Pack)
      end
    end

  end

end