require_relative "Spec_helper"
# require_relative "../lib/far_mar_market"
require_relative "../FarMar"

describe "Testing FarMar Market" do

#before seems like a better choice here, because I don't necessarily want to waste the time needed to read the entire csv file everytime I call a method on markets. But, I don't think my tests can access this variable, because it throws errors when I do it this way.
  # before do
  #   markets = FarMar::Market.all
  # end

  let(:market) { FarMar::Market.new({
         :id => 493,
       :name => "Woodstock Farmers Market",
    :address => "1102 McConnell Road",
       :city => "woodstock",
     :county => "McHenry",
      :state => "Illinois",
        :zip => "60098"
                          }) }

  let(:markets) { FarMar::Market.all }

    it "Confirm that new Market objects can be created" do
      expect(market.class.must_equal(FarMar::Market))
    end

    it "Confirm that create_markets_from_csv reads in each line of the csv file and creates a cooresponding object stored in an array" do
      expect(markets.length > 0).must_equal(true)
      expect(markets.class).must_equal(Array)
      expect(markets[0].class).must_equal(FarMar::Market)
      expect(markets.sample.class).must_equal(FarMar::Market)
    end

  it "Returns the object associated with a given id using find" do
    markets
    # does it return a FarMar::Market object
    expect(FarMar::Market.find(67).class).must_equal(FarMar::Market)
    # does it return the correct FarMar::Market object
    expect(FarMar::Market.find(67).id).must_equal(67)
    # FarMar::Market:0x007f9b191ce3a8 @id=67, @name="Forsyth Farmers' Market", @address="1 West Park Avenue", @city="Savannah", @county="Chatham", @state="Georgia", @zip="31401"
  end

  it ".vendors returns a collection of vendor instances associated with the market" do
  #market id = 493
    expect(market.vendors.sample.market_id).must_equal(493)
    expect(market.vendors.length).must_equal(4)
    #<FarMar::Vendor:0x007ffd1103e7b8 @id=2655, @name="Glover-Hills", @num_employees=11, @market_id=493>,
    #<FarMar::Vendor:0x007ffd1103e718 @id=2656, @name="Langosh and Sons", @num_employees=10, @market_id=493>,
    #<FarMar::Vendor:0x007ffd1103e510 @id=2657, @name="Goyette-Mitchell", @num_employees=4, @market_id=493>,
    #<FarMar::Vendor:0x007ffd1103e498 @id=2658, @name="Becker Inc", @num_employees=10, @market_id=493>
  end

  it ".products returns a collection of product objects that are associated with this market" do
    expect(market.products.class).must_equal(Array)
    expect(market.products.sample.class).must_equal(FarMar::Product)
    expect(market.products.length).must_equal(8)
  # [0] #<FarMar::Product:0x007ffdd9087d78 @id=8085, @name="Pleasant Pretzel", @vendor_id=2655>,
  # [1] #<FarMar::Product:0x007ffdd9087c88 @id=8086, @name="Calm Burrito", @vendor_id=2655>,
  # [2] #<FarMar::Product:0x007ffdd99ec698 @id=8087, @name="Hollow Fish", @vendor_id=2656>,
  # [3] #<FarMar::Product:0x007ffdd99ec5f8 @id=8088, @name="Dry Mushrooms", @vendor_id=2656>,
  # [4] #<FarMar::Product:0x007ffdd99ec5a8 @id=8089, @name="Gigantic Mushrooms", @vendor_id=2656>,
  # [5] #<FarMar::Product:0x007ffdda15c158 @id=8090, @name="Sour Beets", @vendor_id=2657>,
  # [6] #<FarMar::Product:0x007ffdda15c0e0 @id=8091, @name="Immense Beef", @vendor_id=2657>,
  # [7] #<FarMar::Product:0x007ffdd8b2f948 @id=8092, @name="Salty Apples", @vendor_id=2658>
  end

  it ".prefered_vendor returns the vendor with the highest revenue at this market" do
    #does it return a vendor?
    expect(market.prefered_vendor.class).must_equal(FarMar::Vendor)
    #does it return the correct vendor
    expect(market.prefered_vendor.revenue).must_equal(79714)
  end

  it ".worst_vendor returns the vendor with the lowest revenue at this market" do
    #does it return a vendor?
    expect(market.worst_vendor.class).must_equal(FarMar::Vendor)
    #does it return the correct vendor
    expect(market.worst_vendor.revenue).must_equal(40902)
  end
end
