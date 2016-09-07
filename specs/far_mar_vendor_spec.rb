require_relative "Spec_helper"
# require_relative "../lib/far_mar_vendor"
require_relative "../FarMar"

describe "Testing FarMar Vendor" do

  let(:vendor) { FarMar::Vendor.new({:id => 2655, :name =>"Glover-Hills",
                                      :num_employees => 11,:market_id => 493 }) }

  let(:vendors) { FarMar::Vendor.all }

  it "Confirm that new Vendor objects can be created" do
    expect(vendor.class).must_equal(FarMar::Vendor)
  end

  it "Confirm that create_vendors_from_csv reads in each line of the csv file, stores that information in a hash, makes a new object with the hash as a parameter and shovels that object into an array" do

    expect(vendors.length > 0).must_equal(true)
    expect(vendors.class).must_equal(Array)
    expect(vendors[0].class).must_equal(FarMar::Vendor)
  end

  it "Returns the object associated with a given id using find" do
    #check to see if find returns a vendor object
    expect(FarMar::Vendor.find(2650).class).must_equal(FarMar::Vendor)
    #check if the vendor object returned is the correct one
    expect(FarMar::Vendor.find(2650).id).must_equal(2650)
  end

  it ".market returns the market where that vendor sells their goods" do
#<FarMar::Vendor:0x007ffd1103e7b8 @id=2655, @name="Glover-Hills", @num_employees=11, @market_id=493>,
    expect(vendor.market.id).must_equal(493)
  end

  it ".products returns the products that vendor sells" do
  #[0] #<FarMar::Product:0x007fe4623624e8 @id=8085, @name="Pleasant Pretzel", @vendor_id=2655>,
  #[1] #<FarMar::Product:0x007fe462362498 @id=8086, @name="Calm Burrito", @vendor_id=2655>
    expect(vendor.products.length).must_equal(2)
    expect(vendor.products.sample.vendor_id).must_equal(2655)
  end

  it ".sales returns the sales that vendor completed" do
    expect(vendor.sales.sample.vendor_id).must_equal(2655)
  end

  it ".revenue returns the sum amount (in cents) for the sales that vendor completed" do
    expect(vendor.revenue).must_equal(72454)
  end

end
