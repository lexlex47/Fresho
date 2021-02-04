require 'rspec'
require 'spec_helper'
require './lib/invoice'
require './lib/creator'

RSpec.describe Invoice do

  describe "#initialize" do
    it "should take one arguments" do
      expect(Invoice).to respond_to(:new).with(1).argument
    end
    it "should take an array argument" do
      watermelon = Creator.createProduct(:watermelon, "watermelon")
      watermelonItem = Creator.createLineItem(watermelon, 10)
      invoice = Invoice.new([watermelonItem])
      expect(invoice.line_items).to be_an_instance_of(Array)
    end
  end

  describe "#output" do
    it "return if nothing in line_items" do
      invoice = Invoice.new([])
      expect(invoice.output).to be_nil
    end
  end

end