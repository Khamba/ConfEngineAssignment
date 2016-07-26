module SalesTax

  SALES_TAX_EXEMPT_ITEMS = ['book', 'chocolate', 'pill']

  def dismantle_the_sale(str)
    x = str.split(" at ")
    quantity = x[0].split(" ")[0]
    price = x[1].to_f * quantity
    return x[0], price
  end

  def calculate_total_tax(item, price)
    calculate_sales_tax(item, price) + calculate_import_tax(item, price)
  end

  def ceil_to_point_05(n)
    (n * 20).ceil / 20.0
  end

  def calculate_sales_tax(item, price)
    return 0 if SALES_TAX_EXEMPT_ITEMS.any? { |exempt_item| item.include?(exempt_item) }
    ceil_to_point_05(price * 0.1)
  end

  def calculate_import_tax(item, price)
    return 0 unless item.include?('imported')
    ceil_to_point_05(price * 0.05)
  end

end

if $0 == __FILE__

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

  input_array.each do |sale|
    item, price = SalesTax::dismantle_the_sale(sale)
    total_tax_for_sale = SalesTax::calculate_total_tax(item, price)
    total_tax += total_tax_for_sale
    total += price + total_tax_for_sale
    puts(item + ": " + (price + total_tax_for_sale).to_s)
  end

  puts "Sales taxes: #{total_tax}"
  puts "Total: #{total}"

end