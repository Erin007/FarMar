require_relative "Spec_helper"
# require_relative "../lib/far_mar_product"
require_relative "../FarMar"

describe "Testing FarMar Product" do

  let(:product) { FarMar::Product.new({
         :id => 7962,
       :name => "Kickin' Carrots",
       :vendor_id => 2612  }) }

  let(:products) { FarMar::Product.all }

      it "Confirm that new Product objects can be created" do
        expect(product.class.must_equal(FarMar::Product))
      end

      it "Confirm that create_products_from_csv reads in each line of the csv file, creates an object and passes it a hash, stores the object in an array" do
        expect(products.length > 0).must_equal(true)
        expect(products.class).must_equal(Array)
        expect(products[0].class).must_equal(FarMar::Product)
      end

    it "Returns the object associated with a given id using find" do
      #is it returning a product?
      expect(FarMar::Product.find(8178).class).must_equal(FarMar::Product)
      #is it the correct product?

      
    end

    it ".vendor returns the vendor object for the vendor that sells that product" do
      #is it returning a vendor?
      expect(product.vendor.class).must_equal(FarMar::Vendor)
      #is it returning the correct vendor?

    end



end
