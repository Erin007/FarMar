require_relative "Spec_helper"
# require_relative "../lib/far_mar_sale"
require_relative "../FarMar"

describe "Testing FarMar Sale" do
#<FarMar::Sale:0x007fc4bb4b4da8 @id=12, @amount=5179, @purchase_time="2013-11-08 16:36:03 -0800", @vendor_id=3, @product_id=4>
  let(:sale) { FarMar::Sale.new({
         :id => 12,
         :amount => 5179,
         :purchase_time => "2013-11-08 16:36:03 -0800",
         :vendor_id => 3,
         :product_id => 4}) }

  let(:sales) { FarMar::Sale.all }

  it "Confirm that new Sale objects can be created" do
    expect(sale.class.must_equal(FarMar::Sale))
  end

  it "Confirm that create_sales_from_csv reads in each line of the csv file shovels new objects with hash parameters into an array" do

    expect(sales.length > 0).must_equal(true)
    expect(sales.class).must_equal(Array)
    expect(sales[0].class).must_equal(FarMar::Sale)
  end

  it "Returns the object associated with a given id using find" do
    expect(FarMar::Sale.find(12).class).must_equal(FarMar::Sale)
    expect(FarMar::Sale.find(12).amount).must_equal(5179)
  end

  it ".vendor returns the vendor object for the vendor that made this sale" do
    #is it returning a vendor?
    expect(sale.vendor.class).must_equal(FarMar::Vendor)
    #is it returning the correct vendor?
    expect(sale.vendor.id).must_equal(sale.vendor_id)
    expect(sale.vendor.id).must_equal(3)
  end

  it ".product returns the product object for the product sold during this sale" do
    #is it returning a product?
    expect(sale.product.class).must_equal(FarMar::Product)
    #is it returning the correct product?
    expect(sale.product.id).must_equal(sale.product_id)
    expect(sale.product.id).must_equal(4)
  end

  it ".between finds all of the sales that occured in given time window and returns them in an array" do
  expect(FarMar::Sale.between("2013-11-13 05:05:00 -0800", "2013-11-13 05:10:00 -0800").class).must_equal(Array)
  expect(FarMar::Sale.between("2013-11-13 05:05:00 -0800", "2013-11-13 05:10:00 -0800").sample.class).must_equal(FarMar::Sale)
  expect(FarMar::Sale.between("2013-11-13 05:05:00 -0800", "2013-11-13 05:10:00 -0800").length).must_equal(3) #There are 3 sales between 5:05 and 5:10 on Nov. 13, 2013
  expect(FarMar::Sale.between("2013-11-13 05:05:00 -0800", "2013-11-13 05:10:00 -0800").sample.purchase_time >"2013-11-13 05:05:00 -0800").must_equal(true)
  expect(FarMar::Sale.between("2013-11-13 05:05:00 -0800", "2013-11-13 05:10:00 -0800").sample.purchase_time <"2013-11-13 05:10:00 -0800").must_equal(true)
  end 
end
