require_relative "Spec_helper"
require_relative "../lib/far_mar_market"


describe "Testing FarMar Market" do

    it "Confirm that new Market objects can be created" do
      market = FarMar::Market.new({
             :id => 493,
           :name => "Woodstock Farmers Market",
        :address => "1102 McConnell Road",
           :city => "woodstock",
         :county => "McHenry",
          :state => "Illinois",
            :zip => "60098"
    },)
      expect(market.class.must_equal(FarMar::Market))
    end

    it "Confirm that create_markets_from_csv reads in each line of the csv file and creates a cooresponding object stored in an array" do
      FarMar::Market.create_markets_from_csv
      FarMar::Market.all
      expect(FarMar::Market.all.length > 0).must_equal(true)
      expect(FarMar::Market.all.class).must_equal(Array)
      expect(FarMar::Market.all[0].class).must_equal(FarMar::Market)
    end

  it "Returns the object associated with a given id using find" do
    FarMar::Market.create_markets_from_csv
    expect(FarMar::Market.find(67).class).must_equal(FarMar::Market)

  end


end
