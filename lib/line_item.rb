require './lib/selection'

class LineItem

  attr_accessor :product, 
                :quantity, 
                :total_price, 
                :dividends, 
                :result_list,
                :selections 

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
    @total_price = 0
    @dividends = []
    @result_list = []
    @selections = []
    process_flow()
  end

  def process_flow
    set_dividends
    caculate_selection
    find_best_solution
    get_total_price
  end

  def set_dividends
    @dividends = @product.packs.sort_by{|pack| pack.quantity}
  end

  def caculate_selection
    @dividends.each do |dividend|
      result = []
      if @quantity < dividend.quantity
        result << [0, @quantity, dividend.quantity, 0]
        @result_list << result if @result_list.empty?
      else
        tmp = @quantity.divmod(dividend.quantity)
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
        @result_list << result
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
    solution = nil
    divide = true
    return if @result_list.empty?
    solution = find_selection(divide)
    if !solution.empty?
      handle_selections(solution,divide)
      return
    end
    solution = find_selection(!divide)
    handle_selections(solution,!divide)
    return
  end

  def find_selection(divide)
    tmp = []
    @result_list.select{|result| tmp << result if result.last[1] == 0} if divide
    @result_list.select{|result| tmp << result if result.last[1] != 0} if !divide
    return tmp if tmp.empty?
    return tmp.last if divide
    vals = []
    tmp.each do |el|
      val = 0
      el.each{|x| val += x.last}
      val += (el.last[1] * @product.unit_price) if !divide
      vals << val
    end
    tmp[vals.index(vals.min)]
  end

  def handle_selections(solution,divide)
    # [quantity, total_price, pack_quantity]
    solution.each do |s|
      if s.first == 0
        selection = Selection.new(s[1],s[1] * @product.unit_price,1)
        @selections << selection
        return
      end
      selection = Selection.new(s[0],s[3],s[2])
      @selections << selection
    end
    if !divide
      selection = Selection.new(solution.last[1],
                                solution.last[1] * @product.unit_price,
                                1)
      @selections << selection
    end
  end

  def get_total_price
    @total_price = @selections
                    .inject(0){|result, elem| result + elem.total_price}
                    .to_f
                    .round(2)
  end

end