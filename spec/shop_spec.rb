require 'rspec'
require 'spec_helper'
require './lib/shop'

RSpec.describe Shop do

  before do
    Singleton.__init__(Shop)
  end

  describe "#initialize" do
    it "should Shop is a singleton instance" do
      expect(Shop.instance) == "is a Singleton"
    end
  end


end