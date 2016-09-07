require_relative "Spec_helper"
# require_relative "../lib/far_mar_product"
require_relative "../FarMar"

describe "Testing FarMar Product" do

      it "Confirm that new Product objects can be created" do
        product = FarMar::Product.new({:id => 2487, :name => "Gummy Bears",:vendor_id => 1234567})
        expect(product.class.must_equal(FarMar::Product))
      end

      it "Confirm that create_products_from_csv reads in each line of the csv file, creates an object and passes it a hash, stores the object in an array" do
        FarMar::Product.create_products_from_csv
        FarMar::Product.all
        expect(FarMar::Product.all.length > 0).must_equal(true)
        expect(FarMar::Product.all.class).must_equal(Array)
        expect(FarMar::Product.all[0].class).must_equal(FarMar::Product)
      end

    it "Returns the object associated with a given id using find" do
      FarMar::Product.create_products_from_csv
      expect(FarMar::Product.find(8178).class).must_equal(FarMar::Product)
    end



end
