class LineItem

  attr_accessor :product, :quantity, :total_price, :dividends, :result_list

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
    @total_price = 0
    @dividends = []
    @result_list = []
  end

  def set_dividends
    @product.packs
            .sort_by{|pack| pack.quantity}
            .each{|pack| @dividends << pack.quantity}
  end

  def caculate_selection
    @dividends.each do |dividend|
      result = []
      if quantity < dividend
        result << [0, quantity, dividend]
        result_list << result if result_list.empty?
      else
        tmp = quantity.divmod(dividend)
        tmp << dividend
        result << tmp
        remainder = tmp[1]
        if remainder == 0
          result_list << result
        else
          # puts remainder
          while(remainder)
            remainder_cal_res = find_next(remainder)
            break if remainder_cal_res.empty?
            result << remainder_cal_res
            current_remainder = remainder_cal_res[1]
            break if current_remainder == 0
            remainder = current_remainder
          end
          result_list << result
        end
      end
    end
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
    return tmp.empty? ? tmp : tmp.first
  end

end