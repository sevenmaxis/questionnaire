require 'spec_helper'

describe "Checkout" do
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
      checkout.instance_eval{ subtract_discount }.should == 0
    end
  end

  describe "initialize" do
    before(:all) do
      @rule1 = { 'FT' => { :price => 5.0}}
      @rule2 = { 'SR' => { :price => 15.5, :discount => '10%'}}
      @rule3 = { 'CF' => { :price => 4, :discount => '10%'}}
      @rule4 = { 'CU' => { :price => 7, :discount => 5, :start_quantity => 3}}
      @rule5 = { 'AP' => { :price => 3, :discount => '3%', :start_quantity => 5}}
      @rule6 = { 'GP' => { :price => 3, :discount => '3%', :start_quantity => 5}}
      @rule7 = { 'MA' => 5}
    end
    it "Checkout instance should have initialized variables" do
      @checkout = Checkout.new()
      @checkout.instance_eval{ @check}.should be_an_instance_of(Hash)
      @checkout.instance_eval{ @rules}.should be_an_instance_of(Hash)
    end

    it "check the rules in Checkout instance" do
      expect {
        @checkout = Checkout.new(@rule5, @rule6, @rule7)
      }.to_not raise_error
    end

    it "should raise an exception if rule doesn't have all features" do
      expect {
        @checkout = Checkout.new(@rule1,@rule2)
      }.to raise_error(ArgumentError)
    end
  end

  describe "scan" do
    it "should add product item" do

    end

    it "should have two product items" do

    end

    it "should have one product item and two count" do

    end

    it "every item should have a set of hash features" do

    end
  end

  describe "total" do
    it "should return zero sum" do

    end

    it "should return the price of one product" do

    end

    it "should return the sum of two different product" do

    end

    it "should return the sum of two same product" do

    end

    it "should raise an exception on irregular format" do

    end

    describe "rules" do

      describe "product discount" do
        it "check product discount" do

        end

        it "should raise an exception on wrong product price" do
        end
      end

      describe "percentage discount" do
        it "check percentage discount" do

        end

        it "should raise an exception on irregular format" do

        end
      end

      describe "price discount" do
        it "main product without discount product" do

        end

        it "main product with discount product" do

        end
      end
    end
  end

  describe "subtract_discount" do
    it "should raise exception on wrong product discount" do

    end

    it "should return sum to subtract" do

    end

    it "should return sum zero sum" do

    end
  end
end

describe_internally Checkout do
  
end

