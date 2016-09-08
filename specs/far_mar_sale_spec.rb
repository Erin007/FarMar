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
    sale = FarMar::Sale.new({:id => 90909968,
                  :amount => 52,
                  :purchase_time => 8,
                  :vendor_id => 87987567535,
                  :product_id => 867465768})
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

end
