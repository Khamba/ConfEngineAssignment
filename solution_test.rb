require "test/unit"
require File.expand_path(File.dirname(__FILE__)) + "/solution.rb"

class SolutionTest < Test::Unit::TestCase

  def test_dismantle_the_sale_1
    item, price = SalesTax::dismantle_the_sale("1 book at 12.49")
    assert_equal(item, "1 book")
    assert_equal(price, 12.49)
  end

  def test_dismantle_the_sale_2
    item, price = SalesTax::dismantle_the_sale("1 music CD at 14.99")
    assert_equal(item, "1 music CD")
    assert_equal(price, 14.99)
  end

  def test_dismantle_the_sale_3
    item, price = SalesTax::dismantle_the_sale("1 imported bottle of perfume at 27.99")
    assert_equal(item, "1 imported bottle of perfume")
    assert_equal(price, 27.99)
  end

  def test_dismantle_the_sale_4
    exception = assert_raises(SalesException) { SalesTax::dismantle_the_sale("1 imported bottle of perfume 27.99") }
    assert_equal( "invalid input format", exception.message )
  end

  def test_dismantle_the_sale_5
    exception = assert_raises(SalesException) { SalesTax::dismantle_the_sale(123) }
    assert_equal( "invalid input format", exception.message )
  end

  def test_dismantle_the_sale_6
    exception = assert_raises(SalesException) { SalesTax::dismantle_the_sale() }
    assert_equal( "invalid input format", exception.message )
  end

  def test_ceil_to_point_05_1
    assert_equal(1, SalesTax::ceil_to_point_05(1))
  end

  def test_ceil_to_point_05_2
    assert_equal(0.05, SalesTax::ceil_to_point_05(0.04))
  end

  def test_ceil_to_point_05_3
    assert_equal(2.95, SalesTax::ceil_to_point_05(2.9499925))
  end

  def test_ceil_to_point_05_4
    exception = assert_raises(SalesException) { SalesTax::ceil_to_point_05() }
    assert_equal( "argument must be numeric", exception.message )
  end

  def test_ceil_to_point_05_5
    exception = assert_raises(SalesException) { SalesTax::ceil_to_point_05("2.20") } # The function will not support string args
    assert_equal( "argument must be numeric", exception.message )
  end

  def test_calculate_sales_tax_1
    assert_equal(0, SalesTax::calculate_sales_tax("1 book", 12.49))
  end

  def test_calculate_sales_tax_2
    assert_equal(4.50, SalesTax::calculate_sales_tax("1 imported bottle of perfume", 44.58))
  end

  def test_calculate_sales_tax_3
    exception = assert_raises(SalesException) { SalesTax::calculate_sales_tax("2.345") }
    assert_equal( "argument must be string and numeric", exception.message )
  end

  def test_calculate_import_tax_1
    assert_equal(0, SalesTax::calculate_import_tax("1 book", 12.49))
  end

  def test_calculate_import_tax_2
    assert_equal(2.25, SalesTax::calculate_import_tax("1 imported bottle of perfume", 44.58))
  end

  def test_calculate_import_tax_3
    exception = assert_raises(SalesException) { SalesTax::calculate_import_tax("2.345") }
    assert_equal( "argument must be string and numeric", exception.message )
  end

  def test_calculate_total_tax_1
    assert_equal(0, SalesTax::calculate_total_tax("1 book", 12.49))
  end

  def test_calculate_total_tax_2
    assert_equal(6.75, SalesTax::calculate_total_tax("1 imported bottle of perfume", 44.58))
  end

  def test_calculate_total_tax_3
    exception = assert_raises(SalesException) { SalesTax::calculate_total_tax("2.345") }
    assert_equal( "argument must be string and numeric", exception.message )
  end

end