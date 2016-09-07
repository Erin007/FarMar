require_relative "Spec_helper"
# require_relative "../lib/far_mar_sale"
require_relative "../FarMar"

describe "Testing FarMar Sale" do

  it "Confirm that new Sale objects can be created" do
    sale = FarMar::Sale.new({:id => 90909968,
                  :amount => 52,
                  :purchase_time => 8,
                  :vendor_id => 87987567535,
                  :product_id => 867465768})
    expect(sale.class.must_equal(FarMar::Sale))
  end

  it "Confirm that create_sales_from_csv reads in each line of the csv file shovels new objects with hash parameters into an array" do
    FarMar::Sale.create_sales_from_csv
    FarMar::Sale.all
    expect(FarMar::Sale.all.length > 0).must_equal(true)
    expect(FarMar::Sale.all.class).must_equal(Array)
    expect(FarMar::Sale.all[0].class).must_equal(FarMar::Sale)
  end

it "Returns the object associated with a given id using find" do
  FarMar::Sale.create_sales_from_csv
  expect(FarMar::Sale.find(12001).class).must_equal(FarMar::Sale)
end

end
