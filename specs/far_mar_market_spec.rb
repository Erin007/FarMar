require_relative "Spec_helper"
require_relative "../lib/far_mar_market"


describe "Testing FarMar Market" do

    it "Confirm that new Market objects can be created" do
      market = FarMar::Market.new
      expect(market.class.must_equal(FarMar::Market))
    end

end
