class Invoice
  
  attr_accessor :line_items, :total_price

  def initialize(line_items)
    @line_items = line_items
    @total_price = @line_items
                    .inject(0) {|result, element| result + element.total_price}
                    .to_f
                    .round(2) if !@line_items.empty?
  end

  def output()
    return if @line_items.nil? || @line_items.empty?
    puts "********************************************"
    puts "*-------Customer Invoice-------*"
    puts "--------------------------------"
    puts "Quantity\tProduct\t\t\tSubTotal"
    @line_items.each do |item|
      puts "#{item.quantity}\t#{item.product.name}\t\t\t$#{item.total_price.round(2)}"
      item.selections.each do |selection|
        puts "   ---> #{selection.quantity} x #{selection.pack_quantity} pack\t= $#{selection.total_price}"
      end
    end
    puts "--------------------------------"
    puts "TOTAL\t\t\t\t\t$#{@total_price}"
    puts "*********************************************"
  end

end