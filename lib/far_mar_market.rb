# require_relative "../FarMar"
require_relative "far_mar_product"
# require_relative "far_mar_sale"
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
    self.create_markets_from_csv
    return @markets
  end

#self.find(id): returns an instance of the object where the value of the id field in the CSV matches the passed parameter.
  def self.find(id)
    self.all
    @markets.each do |market|
      if market.id == id
        return market
      end
    end
  end

#vendors: returns a collection of FarMar::Vendor instances that are associated with the market by the market_id field.
  def vendors
    vendors_at_this_market = []
    vendors = FarMar::Vendor.all
    vendors.each do |vendor|
      if vendor.market_id == self.id
        vendors_at_this_market << vendor
        end#of if
      end#of do
    return vendors_at_this_market
  end#of method

#products returns a collection of FarMar::Product instances that are associated to the market through the FarMar::Vendor class.
  def products
    products_from_this_market = []
    vendors.each do |vendor|
      products_from_this_market << vendor.products
    end
    return products_from_this_market.flatten
  end

#self.search(search_term) returns a collection of FarMar::Market instances where the market name or vendor name contain the search_term. For example FarMar::Market.search('school') would return 3 results, one being the market with id 75 (Fox School Farmers FarMar::Market).
  def self.search(search_term)
    results_matching_search = []
    @markets.each do |market|
      if market.name.downcase.include? search_term
        results_matching_search << market
        # ap market.name
      end
    end

    @markets.each do |market|
      market.vendors.each do |vendor|
        if vendor.name.downcase.include? search_term
          results_matching_search << market
          # ap vendor.name
        end
      end
    end

    return results_matching_search.uniq
  end

#prefered_vendor: returns the vendor with the highest revenue
  def prefered_vendor_overall
    prefered_vendor = nil
    revenues = []
    vendors.each do |vendor|
      revenues << vendor.revenue
        if vendor.revenue == revenues.max
          prefered_vendor = vendor
        end
      end
      return prefered_vendor
  end

#prefered_vendor(date): returns the vendor with the highest revenue for the given date
#"2013-11-13 05:05:00 -0800"
  def prefered_vendor(date)
    vendor_daily_revenue = Hash.new(0)

    FarMar::Sale.between("#{date} 00:00:00 -800", "#{date} 24:00:00 -800").each do |sale|
            vendor_daily_revenue[sale.vendor_id]+= sale.amount
          end
    return FarMar::Vendor.find(vendor_daily_revenue.key(vendor_daily_revenue.values.max))
  end

#worst_vendor: returns the vendor with the lowest revenue
  def worst_vendor_overall
    worst_vendor = nil
    revenues = []
    vendors.each do |vendor|
      revenues << vendor.revenue
        if vendor.revenue == revenues.min
          worst_vendor = vendor
        end
      end
      return worst_vendor
  end

#worst_vendor(date): returns the vendor with the lowest revenue on the given date
  def worst_vendor(date)
    vendor_daily_revenue = Hash.new(0)

    FarMar::Sale.between("#{date} 00:00:00 -800", "#{date} 24:00:00 -800").each do |sale|
            vendor_daily_revenue[sale.vendor_id]+= sale.amount
          end
    return FarMar::Vendor.find(vendor_daily_revenue.key(vendor_daily_revenue.values.min))
  end
end#of class
