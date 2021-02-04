require 'rspec'
require 'spec_helper'
require './lib/product'
require './lib/products/pineapple'
require './lib/pack'

RSpec.describe Pineapple do

  let(:pineapple) {Pineapple.new("pineapple")}

  describe "#initialize" do
    it "should take one arguments" do
      expect(Pineapple).to respond_to(:new).with(1).argument
    end
  end

  describe "#add_pack" do
    it "should take two arguments" do
      expect(pineapple).to respond_to(:add_pack).with(2).argument
    end

    context "if one of arguments are not numeric" do
      it "should return void" do
        expect(pineapple.add_pack("a",2)).to eq(nil)
      end
    end

    context "if all arguments are valid" do
      before do
        pineapple.add_pack(3, 6.99)
      end

      it "should change packs[]" do
        expect(pineapple.packs.length).to eq(1)
      end
      it "should create a Pack instance" do
        expect(pineapple.packs[0]).to be_an_instance_of(Pack)
      end
    end

  end

end