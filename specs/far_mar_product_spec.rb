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
      expect(FarMar::Product.find(8178).id).must_equal(8178)
    end

    it ".vendor returns the vendor object for the vendor that sells that product" do
      #is it returning a vendor?
      expect(product.vendor.class).must_equal(FarMar::Vendor)
      #is it returning the correct vendor?
      expect(product.vendor.id).must_equal(product.vendor_id)
    end

    it ".sales returns a collection of sales instances that are associated with this product" do
        #is it returning a sales objects?
        expect(product.sales.class).must_equal(Array)
        expect(product.sales.sample.class).must_equal(FarMar::Sale)
        #is it returning the correct sales objects
        expect(product.sales.sample.product_id).must_equal(product.id)
    end

    it ".number_of_sales returns the number of sales associated with this product" do
      #is it returning a number?
      expect(product.number_of_sales.class).must_equal(Fixnum)
      #is it returning the correct number?
      expect(product.number_of_sales).must_equal(4)
    end

    it "self.by_vendor returns all of the vendors with the given product_id" do
      products
      expect(FarMar::Product.by_vendor(2612).class).must_equal(Array)
      expect(FarMar::Product.by_vendor(2612)[0].class).must_equal(FarMar::Product)
    end


end
