class SalesException < Exception 
end
# Simple exception class for gracefull errors.

module SalesTax

  # An array of tax exempt items
  # Since the test inputs had only these items, I only included these but more can be easily added.
  SALES_TAX_EXEMPT_ITEMS = ['book', 'chocolate', 'pill']

  # Dismantle the initial input script.
  # 1 book at 12.49 #=> "1 book", 12.49
  # 4 books at 12.49 #=> "4 books", 49.96
  def self.dismantle_the_sale(str = nil)
    begin
      x = str.split(" at ")

      raise SalesException.new("invalid input format") if x.length != 2

      quantity = x[0].split(" ")[0].to_i
      price = x[1].to_f * quantity

    rescue
      raise SalesException.new("invalid input format")
    end

    return x[0], price
  end

  # Total tax is calculated here. Note that rounding up to 0.05 happens in respective calculate_sales_tax and calculate_import_tax methods.

  def self.calculate_total_tax(item = nil, price = nil)
    raise SalesException.new("argument must be string and numeric") unless item.is_a?(String) and price.is_a?(Numeric)
    
    calculate_sales_tax(item, price) + calculate_import_tax(item, price)
  end

  # a method to round up to .05
  # .05 is hardcoded because not doing so will be big hit to runtime
  def self.ceil_to_point_05(n = nil)
    raise SalesException.new("argument must be numeric") unless n.is_a?(Numeric)

    (n * 20).ceil / 20.0
  end

  def self.calculate_sales_tax(item = nil, price = nil)
    raise SalesException.new("argument must be string and numeric") unless item.is_a?(String) and price.is_a?(Numeric)
    
    return 0 if SALES_TAX_EXEMPT_ITEMS.any? { |exempt_item| item.include?(exempt_item) }
    ceil_to_point_05(price * 0.1)
  end

  def self.calculate_import_tax(item = nil, price = nil)
    raise SalesException.new("argument must be string and numeric") unless item.is_a?(String) and price.is_a?(Numeric)
    
    return 0 unless item.include?('imported')
    ceil_to_point_05(price * 0.05)
  end

end

if $0 == __FILE__ # This is so that if file is required in test script, then the module will be loaded but following code wont interfere.

  input_array = Array.new
  inp = ""

  puts "Enter input lines (press q on new line when all inputs are entered)"

  loop do
    inp = gets.chomp
    break if inp == "q"
    input_array << inp
  end

  total_tax = 0.0
  total = 0.0

  puts "-------------------"

  input_array.each do |sale|
    begin
      item, price = SalesTax::dismantle_the_sale(sale)
      total_tax_for_sale = SalesTax::calculate_total_tax(item, price)
    rescue SalesException => e
      abort e.message
    end
    total_tax += total_tax_for_sale
    total += price + total_tax_for_sale
    puts(item + ": " + sprintf("%.2f", price + total_tax_for_sale))
  end

  puts "Sales taxes: #{sprintf('%.2f', total_tax)}"
  puts "Total: #{sprintf('%.2f', total)}"

end