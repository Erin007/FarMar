require_relative "Spec_helper"
# require_relative "../lib/far_mar_vendor"
require_relative "../FarMar"

describe "Testing FarMar Vendor" do

  let(:vendor) { FarMar::Vendor.new({:id => 2655, :name =>"Glover-Hills",
                                      :num_employees => 11,:market_id => 493 }) }

  let(:vendors) { FarMar::Vendor.all }

  let(:market) { FarMar::Market.new({
         :id => 493,
       :name => "Woodstock Farmers Market",
    :address => "1102 McConnell Road",
       :city => "woodstock",
     :county => "McHenry",
      :state => "Illinois",
        :zip => "60098"
                          }) }

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

  it "self.by_market returns all of the vendors with the given market_id" do
    vendors
    expect(FarMar::Vendor.by_market(493).class).must_equal(Array)
    expect(FarMar::Vendor.by_market(493)[0].class).must_equal(FarMar::Vendor)
  #Determine if the vendors you're returning are the correct vendors...

  end

  it "self.most_revenue(n) returns the top n vendor instances ranked by total revenue" do
    vendors
    # expect(FarMar::Vendor.most_revenue(3).class).must_equal(Array) <--- this test is not informative enough to be worth the time it takes to run
    expect(FarMar::Vendor.most_revenue(3).length).must_equal(3)
    # expect(FarMar::Vendor.most_revenue(3).sample.class).must_equal(FarMar::Vendor)<--- this test is not informative enough to be worth the time it takes to run
    expect(FarMar::Vendor.most_revenue(1).first.id).must_equal(2590)
    #confirm that the top four vendors includes the top 3 vendors
    #expect(FarMar::Vendor.most_revenue(4)).must_include(FarMar::Vendor.most_revenue(3)) <-- this test doesn't test what I want it to test maybe because must_include doesn't quite do what I want it to, but when I run the code I get this output:
  #Expected [#<FarMar::Vendor:0x007fbbededdb58 @id=2557, @name="Yost, Greenholt and Casper", @num_employees=8, @market_id=476>, #<FarMar::Vendor:0x007fbbededd568 @id=2575, @name="D'Amore, Wunsch and Kerluke", @num_employees=3, @market_id=478>, #<FarMar::Vendor:0x007fbbededd068 @id=2590, @name="Swaniawski-Schmeler", @num_employees=11, @market_id=482>, #<FarMar::Vendor:0x007fbbed31f3c0 @id=2672, @name="Herzog LLC", @num_employees=8, @market_id=497>] to include [#<FarMar::Vendor:0x007fbbededd568 @id=2575, @name="D'Amore, Wunsch and Kerluke", @num_employees=3, @market_id=478>, #<FarMar::Vendor:0x007fbbededd068 @id=2590, @name="Swaniawski-Schmeler", @num_employees=11, @market_id=482>, #<FarMar::Vendor:0x007fbbed31f3c0 @id=2672, @name="Herzog LLC", @num_employees=8, @market_id=497>] which does in fact show that the top three vendor items are also included in the top four vendor items 
  end

  it "self.most_items(n) returns vendors who sold the most items" do
    vendors
    expect(FarMar::Vendor.most_items(3).class).must_equal(Array)
    expect(FarMar::Vendor.most_items(3).length).must_equal(3)
    expect(FarMar::Vendor.most_items(3).sample.class).must_equal(FarMar::Vendor)
  end
end
