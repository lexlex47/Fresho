class LineItem

  attr_accessor :product, :quantity, :total_price, :dividends, :result_list

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
    @total_price = 0
    @dividends = []
    @result_list = nil
  end

  def set_dividends
    @product.packs.each{|pack| @dividends << pack.quantity}
    # puts @product.packs.length
    # # @product.packs.each{|pack| puts pack.quantity}
  end

  def caculator

  end

  def caculate_left_over
  end

  def find_next(num)
    tmp = []
    @dividends.each do |dividend|
      next if num < dividend
      result = num.divmod(dividend)
      result << dividend
      if result[1] == 0
        return result 
      end
      tmp << result
    end
    return tmp.min_by{|t| t[1]} if tmp.size > 1
    return tmp
  end

end