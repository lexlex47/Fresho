require 'rspec'
require 'spec_helper'
require './lib/line_item'

RSpec.describe LineItem do

  describe "#initialize" do
    it "should take two arguments" do
      expect(LineItem).to respond_to(:new).with(2).argument
    end
  end

end