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
    self.all
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

#revenue: returns the the sum of all of the vendor's sales (in cents)
  def revenue
    revenue_amount = 0
    sales.each do |sale|
    revenue_amount += sale.amount
      end
    return revenue_amount
  end

#self.by_market(market_id): returns all of the vendors with the given market_id
  def self.by_market(market_id)
    vendors_with_this_market_id = []
      @vendors.each do |vendor|
      if vendor.market_id == market_id
        vendors_with_this_market_id << vendor
      end
    end
    return vendors_with_this_market_id
  end

# self.most_revenue(n) returns the top n vendor instances ranked by total revenue
  def self.most_revenue(n)
    revenues = [0]
    vendors_with_highest_revenues =[]

    @vendors.each do |vendor|
      if revenues.length == n
        if vendor.revenue > revenues.min
        revenues.delete_at(revenues.index(revenues.min))
        revenues << vendor.revenue
        end
      else
        revenues << vendor.revenue
      end
    end

    @vendors.each do |vendor|
      if revenues.sort.include?(vendor.revenue)
        vendors_with_highest_revenues << vendor
      end
    end
    return vendors_with_highest_revenues
  end

# self.most_items(n) returns the top n vendor instances ranked by total number of items sold

#NOTES: So, it appears as though there is a 29-way tie of vendors who sold the max (18 items). My method will return all of the vendors not just the top n because it doesn't know what to do if the vendors sold the same number of items.
  def self.most_items(n)
    sales_counts = [0]
    vendors_who_sold_most_items =[]

        @vendors.each do |vendor|
          if sales_counts.length == n
            if vendor.sales.length > sales_counts.min && vendor.sales.length < sales_counts.max
            sales_counts.delete_at(sales_counts.index(sales_counts.min))
            sales_counts << vendor.sales.length
            end
          else
            sales_counts << vendor.sales.length
          end
        end

        @vendors.each do |vendor|
          sales_counts.sort!
          if sales_counts.include?(vendor.sales.length)
            vendors_who_sold_most_items << vendor
          end
        end
        return vendors_who_sold_most_items
  end

end#of class
