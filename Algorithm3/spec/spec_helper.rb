$LOAD_PATH << File.expand_path('../../../lib', __FILE__)

require 'grocery_store'

def describe_internally *args, &block
  example = describe *args, &block
  klass = args[0]
  if klass.is_a? Class
    saved_private_instance_methods = klass.private_instance_methods
    example.before do
      klass.class_eval { public *saved_private_instance_methods }
    end
    example.after do
      klass.class_eval { private *saved_private_instance_methods }
    end
  end
end

#@wrong_rule1 = {'FT' => {:price => 5.0}}
#@wrong_rule2 = {'SR' => {:price => 15.5, :discount => '10%'}}
#@wrong_rule3 = {'CF' => {:price => 4, :discount => '10%'}}
#@wrong_rule4 = {'MX' => 2000000000000000}
#@rule1 = {'CU' => {:price => 7, :discount => 5, :start_quantity => 3}}
#@rule2 = {'AP' => {:price => 3, :discount => '3%', :start_quantity => 5}}
#@rule3 = {'GP' => { :price => 2, :discount => 'MA', :start_quantity => 4}}
#@rule4 = {'MA' => 5}