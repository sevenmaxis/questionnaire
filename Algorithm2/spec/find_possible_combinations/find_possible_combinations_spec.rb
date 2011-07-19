require 'spec_helper'

describe "find possible combinations" do

  it "should return empty array" do
    dictionary = ['a', 'b', 'c', 'ab', 'abc']
    target = 'aabcx'
    result = find_possible_combinations(dictionary, target)
    result.should have(0).things
  end

  it "result array should have size 3" do
    dictionary = ['a', 'b', 'c', 'ab', 'abc']
    target = 'aabc'
    result = find_possible_combinations(dictionary, target)
    result.should have(3).things
  end

  it "should find 3 elements in result" do
    # because The order in which combinations are returned is
    # irrelevant.
    dictionary = ['a', 'b', 'c', 'ab', 'abc']
    target = 'aabc'
    result = find_possible_combinations(dictionary, target)
    expected = ['a abc', 'a a b c', 'a ab c']
    count = 0
    result.each do |r|
      expected.each do |e|
        if r.split.sort.join == e.split.sort.join
          count += 1
          break
        end
      end
    end
    count.should == 3
  end
end