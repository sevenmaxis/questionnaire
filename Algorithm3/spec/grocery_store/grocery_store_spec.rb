require 'spec_helper'

describe "Checkout" do
  before(:all) do
    @wrong_rule1 = { 'FT' => { :price => 5.0}}
    @wrong_rule2 = { 'SR' => { :price => 15.5, :discount => '10%'}}
    @wrong_rule3 = { 'CF' => { :price => 4, :discount => '10%'}}
    @wrong_rule4 = { 'MX' => 2000000000000000}
    @rule1 = { 'CU' => { :price => 7, :discount => 5, :start_quantity => 3}}
    @rule2 = { 'AP' => { :price => 3, :discount => '3%', :start_quantity => 5}}
    @rule3 = { 'GP' => { :price => 2, :discount => 'MA', :start_quantity => 4}}
    @rule4 = { 'MA' => 5}
  end

  describe "instantiation" do
    let(:checkout) { Checkout.new }

    it "should create instance of class Checkout" do
      checkout.should be
      checkout.should be_an_instance_of(Checkout)
    end

    it "Checkout instance should respond to methods" do
      checkout.should respond_to(:scan, :total)
    end

    it "Checkout instance should not respond to private method" do
      checkout.should_not respond_to(:subtract_discount)
    end
  end

  describe "initialize" do

    it "Checkout instance should have initialized variables" do
      checkout = Checkout.new()
      checkout.instance_eval{ @check}.should be_an_instance_of(Hash)
      checkout.instance_eval{ @rules}.should be_an_instance_of(Hash)
    end

    it "check the rules in Checkout instance" do
      expect {
        Checkout.new(@rule1, @rule2, @rule3)
      }.to_not raise_error
    end

    it "should raise an exception if rule doesn't have all features" do
      expect {
        Checkout.new(@wrong_rule1)
      }.to raise_error(ArgumentError,
        "The rule should have all features: price, discount and " +
            "start_quantity. Error for product: #{@wrong_rule1.keys[0]}")
    end
  end

  describe "scan" do

    it "should add product item" do
      checkout = Checkout.new(@rule1)
      checkout.scan('CU')
      checkout.instance_eval{ @check['CU'][:count]}.should == 1
    end

    it "should raise an error on unwritten products" do
      @checkout = Checkout.new(@rule1,@rule2,@rule3)
      expect {
        @checkout.scan('XZ')
      }.to raise_error(ArgumentError, "There's no rule for product XZ")
    end
  end

  describe "total" do
    it "should return zero sum" do
      checkout = Checkout.new()
      checkout.total.should == 0
    end

    it "should return the price of one product" do
      checkout = Checkout.new(@rule1)
      checkout.scan('CU')
      checkout.total.should == 7
    end

    it "should return the sum of two different product" do
      checkout = Checkout.new(@rule1,@rule2)
      checkout.scan('CU')
      checkout.scan('AP')
      checkout.total.should == 10
    end

    it "should return the sum of two same product" do
      checkout = Checkout.new(@rule1)
      checkout.scan('CU')
      checkout.scan('CU')
      checkout.total.should == 14
    end

    it "should raise an exception on irregular format" do
      checkout = Checkout.new(@wrong_rule4)
      checkout.scan('MX')
      expect { checkout.total }.to raise_error(ArgumentError,
        "The price of product MX has irregular format." +
            "It should be not more then 99999.99")
    end

    describe "rules" do

      describe "price discount" do
        it "check price discount" do
          checkout = Checkout.new(@rule1)
          2.times { checkout.scan('CU') }
          checkout.total.should == 14
          checkout.scan('CU')
          checkout.total.should == 15
        end

        it "should raise an exception on wrong product price" do
        end
      end

      describe "percentage discount" do
        it "check percentage discount" do
          checkout = Checkout.new(@rule2)
          4.times { checkout.scan('AP') }
          checkout.total.should == 12
          checkout.scan('AP')
          checkout.total.should == 14.55
          checkout.scan('AP')
          checkout.total.should == 17.46
        end

        it "should raise an exception on irregular format" do

        end
      end

      describe "product discount" do
        it "product discount" do
          checkout = Checkout.new(@rule3,@rule4)
          3.times { checkout.scan('GP') }
          checkout.scan('MA')
          checkout.total.should == 11
          checkout.scan('GP')
          checkout.total.should == 8
        end

      end
    end
  end
end

