#   grocery_rule = {
#     'FT(Fruit Tea)' => {  :price => 111,
#                          :discount => 'product_code (Fruit Tea) or
#                                         % discount (20%) or
#                                         price per each (4.5)',
#                         :start_quantity => 'the quantity of products to get discount' }
#   }
#  "Fruit Tea" => "FT",
#  "Strawberries" => "SR",
#  "Coffee" => "CF"

grocery_rule1 = {}
grocery_rule2 = {}
grocery_rule3 = {}

class Checkout
  #check = { 'FT' =>
  #       { :price => 111, :count => 3, :discount => '20%', :start_quantity => 5 }
  # }
  def initialize(*rules)
    @check = {}
    @rules = {}
    rules.each { |r| @rules.merge!(r) }
    @rules.each_pair do |product, rule|
      if rule.kind_of?(Hash)
        unless rule.has_key?(:price) and rule.has_key?(:discount) and rule.has_key?(:start_quantity)
          raise ArgumentError, "The rule should have all features: " +
              "price, discount and start_quantity. Error for product: #{product}"
        end
      end
    end
  end

  def scan(product_name)
    if @check.has_key?(product_name)
      @check[product_name][:count] += 1
    elsif @rules.has_key?(product_name)
      rule = @rules[product_name]
      @check[product_name] = rule.is_a?(Hash) ?
          {:count => 1}.merge!(rule) : {:count => 1, :price => rule}
    else
      raise ArgumentError, "There's no rule for product #{product_name}"
    end
  end

  def total
    sum = 0
    @check.each_pair do |key, value|
      if value[:price] > 99999.99
        raise ArgumentError, "The price of product #{key} has irregular format." +
            "It should be not more then 99999.99"
      end
      if value.has_key?(:discount) and value[:count] >= value[:start_quantity]
        case value[:discount]
          when /^\d{1,2}%$/ # percentage discount
            discount = value[:discount].sub('%', '').to_f
            if discount > 99 or discount < 1
              raise ArgumentError, "The percentage of discount has " +
                  "irregular format: #{value[:discount]}"
            end
            sum += value[:price] * (100 - discount) * value[:count] / 100
            sum = sum.round(2)
          when /[a-z_\-]*/i # here's should be the product name
            sum += value[:price] * value[:count]
            sum -= subtract_discount(value[:discount], value[:price])
          else
            if value[:discount].kind_of?(Numeric)
              sum += value[:discount] * value[:count]
            else
              raise ArgumentError, "Discount has irregular format: #{value[:discount]}"
            end
        end
      else
        sum += value[:price] * value[:count]
      end
    end
    sum
  end

  private
  # additional functionality as a bonus
  def subtract_discount(product_name, elder_price)
    if @check.has_key?(product_name)
      price = @check[product_name][:price]
      if elder_price > price
        raise ArgumentError, "Discount product can't be more expensive than main " +
            "product: main product price #{elder_price}, discount product price #{price}"
      end
      return price
    end
    return 0
  end

  def get_hash(product_name)
  end
end

