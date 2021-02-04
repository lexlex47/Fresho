require 'rspec'
require 'spec_helper'
require './lib/selection'

RSpec.describe Selection do

  describe "#initialize" do
    
    it "should take three arguments" do
      expect(Selection).to respond_to(:new).with(3).argument
    end

    it "should have total_price is a float and rounded 2" do
      selection = Selection.new(0,1.245,0)
      expect(selection.total_price).to be_an_instance_of(Float)
      expect(selection.total_price).to eq(1.25)
    end

  end

end