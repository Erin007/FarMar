require_relative "../FarMar"
require_relative "far_mar_product"
require_relative "far_mar_market"
require_relative "far_mar_vendor"

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
    return @sales
  end
#self.find(id): returns an instance of the object where the value of the id field in the CSV matches the passed parameter.
  def self.find(id)
    @sales.each do |sale|
      if sale.id == id
        return sale
      end
    end
  end

end
