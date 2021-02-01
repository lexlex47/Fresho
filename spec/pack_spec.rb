require 'rspec'
require 'spec_helper'
require './lib/pack'

RSpec.describe Pack do

  describe "#initialize" do
    
    it "should take two arguments" do
      expect(Pack).to respond_to(:new).with(2).argument
    end

    it "should have two numeric arguments" do
      pack = Pack.new(3,6.99)
      expect(pack.quantity).to be_a Numeric
      expect(pack.price).to be_a Numeric
    end

  end

end