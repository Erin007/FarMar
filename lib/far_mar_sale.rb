# require_relative "../FarMar"
# require_relative "far_mar_product"
# require_relative "far_mar_market"
# require_relative "far_mar_vendor"

class FarMar::Sale

  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id, :sale_hash, :sales

  def initialize(sale_hash)
    @id = sale_hash[:id]
    @amount = sale_hash[:amount]
    @purchase_time = sale_hash[:purchase_time]
    @vendor_id = sale_hash[:vendor_id]
    @product_id = sale_hash[:product_id]
  end

  def self.create_sales_from_csv
    sale_hash = {}
    @sales = []
    CSV.read("/Users/erinbond/desktop/ada/week_5/FarMar/support/sales.csv", 'r').each do |row|
      sale_hash = {:id => row[0].to_i,
                    :amount => row[1].to_i,
                    :purchase_time => row[2],
                    :vendor_id => row[3].to_i,
                    :product_id => row[4].to_i}

      @sales << FarMar::Sale.new(sale_hash)
    end
    return @sales
  end
#self.all: returns a collection of instances, representing all of the objects described in the CSV
  def self.all
    self.create_sales_from_csv
    return @sales
  end
#self.find(id): returns an instance of the object where the value of the id field in the CSV matches the passed parameter.
  def self.find(id)
    self.all
    @sales.each do |sale|
      if sale.id == id
        return sale
      end
    end
  end

#vendor: returns the FarMar::Vendor instance that is associated with this sale using the FarMar::Sale vendor_id field
  def vendor
    vendor_that_made_this_sale = nil
    vendors = FarMar::Vendor.all
    vendors.each do |vendor|
      if vendor.id == self.vendor_id
        vendor_that_made_this_sale = vendor
        return vendor_that_made_this_sale
      end#of if
      end#of do
  end#of method

#product: returns the FarMar::Product instance that is associated with this sale using the FarMar::Sale product_id field
  def product
    product_sold = nil
    products = FarMar::Product.all
    products.each do |product|
      if product.id == self.product_id
        product_sold = product
        return product_sold
      end#of if
      end#of do
  end#of method

#self.between(beginning_time, end_time): returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments

end

FarMar::Sale.all
ap FarMar::Sale.find(12)
