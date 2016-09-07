require_relative "../FarMar"
require_relative "far_mar_product"
require_relative "far_mar_sale"
require_relative "far_mar_market"

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

end

# ap FarMar::Vendor.create_vendors_from_csv
