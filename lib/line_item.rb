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
    @dividends = @product.packs.sort_by{|pack| pack.quantity}
            # .each{|pack| @dividends << pack.quantity}
  end

  def caculate_selection
    @dividends.each do |dividend|
      result = []
      if quantity < dividend.quantity
        result << [0, quantity, dividend.quantity, @product.unit_price * quantity]
        result_list << result if result_list.empty?
      else
        tmp = quantity.divmod(dividend.quantity)
        tmp << dividend.quantity
        tmp << tmp[0] * dividend.price
        result << tmp
        remainder = tmp[1]
        if remainder != 0
          while(remainder)
            remainder_cal_res = find_next(remainder)
            break if remainder_cal_res.empty?
            result << remainder_cal_res
            current_remainder = remainder_cal_res[1]
            break if current_remainder == 0
            remainder = current_remainder
          end
        end
        result_list << result
        # if remainder == 0
        #   result_list << result
        # else
        #   while(remainder)
        #     remainder_cal_res = find_next(remainder)
        #     break if remainder_cal_res.empty?
        #     result << remainder_cal_res
        #     current_remainder = remainder_cal_res[1]
        #     break if current_remainder == 0
        #     remainder = current_remainder
        #   end
        #   result_list << result
        # end
      end
    end
  end

  def find_next(num)
    tmp = []
    @dividends.each do |dividend|
      next if num < dividend.quantity
      result = num.divmod(dividend.quantity)
      result << dividend.quantity
      result << result[0] * dividend.price
      if result[1] == 0
        return result 
      end
      tmp << result
    end
    return tmp.min_by{|t| t[1]} if tmp.size > 1
    return tmp.empty? ? tmp : tmp.first
  end

  def find_best_solution
    return if result_list.empty?
    zero_solutions = []
    result_list.select{|result| zero_solutions << result if result.last[1] == 0}
  end

  def caculate_selection_price(selection)
    sum = 0
    selection.each{|elm| }
  end

end