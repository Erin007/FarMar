# require_relative "../FarMar"
# require_relative "far_mar_market"
# require_relative "far_mar_sale"
# require_relative "far_mar_vendor"

class FarMar::Product

  attr_accessor :id, :name, :vendor_id, :product_hash, :products

  def initialize(product_hash)
    @id = product_hash[:id]
    @name = product_hash[:name]
    @vendor_id = product_hash[:vendor_id]
  end

  def self.create_products_from_csv
    product_hash = {}
    @products = []
    CSV.read("/Users/erinbond/desktop/ada/week_5/FarMar/support/products.csv", 'r').each do |row|
      product_hash = {:id =>row[0].to_i,
                    :name =>row[1],
                    :vendor_id =>row[2].to_i}
      @products << FarMar::Product.new(product_hash)
    end
    return @products
  end
#self.all: returns a collection of instances, representing all of the objects described in the CSV
  def self.all
    self.create_products_from_csv
    return @products
  end
#self.find(id): returns an instance of the object where the value of the id field in the CSV matches the passed parameter.
  def self.find(id)
    @products.each do |product|
      if product.id == id
        return product
      end
    end
  end

end
