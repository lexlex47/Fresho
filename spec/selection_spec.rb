require 'rspec'
require 'spec_helper'
require './lib/selection'

RSpec.describe Selection do

  describe "#initialize" do
    
    it "should take three arguments" do
      expect(Selection).to respond_to(:new).with(3).argument
    end

  end

end