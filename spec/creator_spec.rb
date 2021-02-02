require 'rspec'
require 'spec_helper'
require './lib/creator'
require './lib/watermelon'

RSpec.describe Creator do

  describe "#create" do
    
    it "should take two arguments" do
      expect(Creator).to respond_to(:create).with(2).argument
    end

    context "if type is Watermelon" do
      it "should create a watermelon object" do
        watermelon = Creator.create(:watermelon, "watermelon")
        expect(watermelon).to be_an_instance_of(WaterMelon)
      end
    end

  end

end