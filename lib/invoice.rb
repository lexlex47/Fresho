class Invoice
  
  attr_accessor :total_price

  def initialize(line_items)
    @line_items = line_items
    @total_price = 0
  end

  

  def output()
  end

end