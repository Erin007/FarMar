# require_relative "../FarMar"
# require_relative "far_mar_product"
require_relative "far_mar_sale"
# require_relative "far_mar_market"

class FarMar::Vendor
  attr_accessor :id, :name, :num_employees, :market_id, :vendors, :vendor_hash

  def initialize(vendor_hash)
    @id = vendor_hash[:id]
    @name = vendor_hash[:name]
    @num_employees = vendor_hash[:num_employees]
    @market_id = vendor_hash[:market_id]

  end

  def self.create_vendors_from_csv
    vendor_hash = {}
    @vendors = []
    CSV.read("/Users/erinbond/desktop/ada/week_5/FarMar/support/vendors.csv", 'r').each do |row|
      vendor_hash = {:id =>row[0].to_i,
                    :name =>row[1],
                    :num_employees =>row[2].to_i,
                    :market_id =>row[3].to_i}
      @vendors << FarMar::Vendor.new(vendor_hash)
    end
    return @vendors
  end

#self.all: returns a collection of instances, representing all of the objects described in the CSV
  def self.all
    self.create_vendors_from_csv
    return @vendors
  end

#self.find(id): returns an instance of the object where the value of the id field in the CSV matches the passed parameter.
  def self.find(id)
    @vendors.each do |vendor|
      if vendor.id == id
        return vendor
      end
    end
  end
#market: returns the FarMar::Market instance that is associated with this vendor using the FarMar::Vendor market_id field
def market
  market_where_this_vendor_sells = nil
  markets_to_check = FarMar::Market.all
  markets_to_check.each do |market_to_check|
    if self.market_id == market_to_check.id
      market_where_this_vendor_sells = market_to_check
      end#of if
    end#of do
  return market_where_this_vendor_sells
end#of method

#products: returns a collection of FarMar::Product instances that are associated by the FarMar::Product vendor_id field.
def products
  products_this_vendor_sells = []
  products_to_check = FarMar::Product.all
  products_to_check.each do |product_to_check|
    if self.id == product_to_check.vendor_id
        products_this_vendor_sells << product_to_check
      end#of if
    end#of do
  return products_this_vendor_sells
end#of method

#sales: returns a collection of FarMar::Sale instances that are associated by the vendor_id field.
def sales
  sales_this_vendor_made = []
  sales_to_check = FarMar::Sale.all
  sales_to_check.each do |sale_to_check|
    if self.id == sale_to_check.vendor_id
        sales_this_vendor_made << sale_to_check
      end#of if
    end#of do
  return sales_this_vendor_made
end#of method


end

 vendor = FarMar::Vendor.new({:id => 2655, :name =>"Glover-Hills",:num_employees => 11,:market_id => 493 })
# ap vendor
#ap vendor.products
ap vendor.sales
