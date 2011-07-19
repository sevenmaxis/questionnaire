require 'spec_helper'

describe "adding element to array" do

  it "should increase size of array" do
    find_counts([]).length.should == 0
    find_counts(['foo']).length.should == 1
    find_counts(['foo','foo1']).length.should == 2
  end

  it "original element should have one count" do
    item = find_counts(['foo','foo1','foo2'])[0]
    item.count.should == 1
  end

  it "two same elements should have count = 2" do
    item = find_counts(['foo','zoo','foo'])[0]
    item.count.should == 2
  end
  
end

describe "sort elements in array" do
  it "should order by alphabetical order" do
    items = find_counts(['abc', 'xyz', 'xyz', 'abc'])
    items[0].word.should == 'abc'
    items[1].word.should == 'xyz'
  end

  it "should order by descending order" do
    items = find_counts(['abc', 'def', 'abc'])
    items[0].word.should == 'abc'
    items[1].word.should == 'def'
  end

end