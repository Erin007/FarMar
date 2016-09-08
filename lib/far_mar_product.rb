# require_relative "../FarMar"
# require_relative "far_mar_market"
# require_relative "far_mar_sale"
require_relative "far_mar_vendor"

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

#vendor: returns the FarMar::Vendor instance that is associated with this vendor using the FarMar::Product vendor_id field
  def vendor
    vendor_that_sells_this_product = nil
    vendors = FarMar::Vendor.all
    vendors.each do |vendor|
      if vendor.id == self.vendor_id
        vendor_that_sells_this_product = vendor
        return vendor_that_sells_this_product
      end#of if
      end#of do
  end#of method

#sales: returns a collection of FarMar::Sale instances that are associated using the FarMar::Sale product_id field.
  def sales
    sales_of_this_product = []
    sales = FarMar::Sale.all
    sales.each do |sale|
      if sale.product_id == self.id
        sales_of_this_product << sale
        end#of if
      end#of do
    return sales_of_this_product
  end#of method

#number_of_sales: returns the number of times this product has been sold.
  def number_of_sales
    return sales.length
  end#of method

#self.by_vendor(vendor_id): returns all of the products with the given vendor_id
  def self.by_vendor(vendor_id)
    products_with_this_vendor_id = []
      @products.each do |product|
      if product.vendor_id == vendor_id
        products_with_this_vendor_id << product
      end
    end
    return products_with_this_vendor_id
  end

end#of class



#[7961] #<FarMar::Product:0x007f8d5c164360 @id=7962, @name="Kickin' Carrots", @vendor_id=2612>,
#[7962] #<FarMar::Product:0x007f8d5c164310 @id=7963, @name="Good Mushrooms", @vendor_id=2612>,
