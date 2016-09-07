require_relative "../FarMar"
require_relative "far_mar_product"
require_relative "far_mar_sale"
require_relative "far_mar_vendor"

class FarMar::Market
  attr_accessor :id, :name, :address, :city, :county, :state, :zip, :market_hash, :markets

  def initialize(market_hash)
    @id = market_hash[:id]
    @name = market_hash[:name]
    @address = market_hash[:address]
    @city = market_hash[:city]
    @county = market_hash[:county]
    @state = market_hash[:state]
    @zip = market_hash[:zip]
    @markets = []
  end

  def self.create_markets_from_csv
    market_hash = {}
    @markets = []
    CSV.read("/Users/erinbond/desktop/ada/week_5/FarMar/support/markets.csv", 'r').each do |row|
      market_hash = {:id =>row[0].to_i,
                    :name =>row[1],
                    :address =>row[2],
                    :city =>row[3],
                    :county =>row[4],
                    :state =>row[5],
                    :zip =>row[6]}
      @markets << FarMar::Market.new(market_hash)
    end
    return @markets
  end

#self.all: returns a collection of instances, representing all of the objects described in the CSV
  def self.all
    return @markets
  end

#self.find(id): returns an instance of the object where the value of the id field in the CSV matches the passed parameter.
  def self.find(id)
    @markets.each do |market|
      if market.id == id
        return market
      end
    end
  end
end#of class
