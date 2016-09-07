require_relative "Spec_helper"
# require_relative "../lib/far_mar_vendor"
require_relative "../FarMar"

describe "Testing FarMar Vendor" do

  it "Confirm that new Vendor objects can be created" do
    vendor = FarMar::Vendor.new({:id => 8675309,
                                :name =>"Bumbleroot Farm",
                                :num_employees => 5,
                                :market_id => 4567890})
    expect(vendor.class).must_equal(FarMar::Vendor)
  end

  it "Confirm that create_vendors_from_csv reads in each line of the csv file, stores that information in a hash, makes a new object with the hash as a parameter and shovels that object into an array" do
    FarMar::Vendor.create_vendors_from_csv
    FarMar::Vendor.all
    expect(FarMar::Vendor.all.length > 0).must_equal(true)
    expect(FarMar::Vendor.all.class).must_equal(Array)
    expect(FarMar::Vendor.all[0].class).must_equal(FarMar::Vendor)
  end

  it "Returns the object associated with a given id using find" do
    FarMar::Vendor.create_vendors_from_csv
    expect(FarMar::Vendor.find(2650).class).must_equal(FarMar::Vendor)
  end

end
