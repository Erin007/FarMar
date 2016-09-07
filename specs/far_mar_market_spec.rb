require_relative "Spec_helper"
require_relative "../lib/far_mar_market"

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

end
