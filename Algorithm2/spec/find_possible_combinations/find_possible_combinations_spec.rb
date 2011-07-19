require 'spec_helper'

describe "find possible combinations" do
  # because The order in which combinations are
  # returned is irrelevant.
  def calculate_matches(array1, array2)
    count = 0
    array1.each do |a1|
      array2.each do |a2|
        if a1.split.sort.join == a2.split.sort.join
          count += 1
          break
        end
      end
    end
    count
  end

  it "should return empty array" do
    dictionary = ['a', 'b', 'c', 'ab', 'abc']
    target = 'aabcx'
    result = find_possible_combinations(dictionary, target)
    result.should have(0).things
  end

  it "result array should have 3 things" do
    dictionary = ['a', 'b', 'c', 'ab', 'abc']
    target = 'aabc'
    result = find_possible_combinations(dictionary, target)
    puts "==== result array should have 3 things ===="
    puts result
    result.should have(3).things
  end

  it "should find 3 elements" do
    # because The order in which combinations are returned
    # is irrelevant.
    dictionary = ['a', 'b', 'c', 'ab', 'abc']
    target = 'aabc'
    result = find_possible_combinations(dictionary, target)
    expected = ['a abc', 'a a b c', 'a ab c']
    calculate_matches(result, expected).should == 3
    puts "==== should find 3 elements in result ===="
    puts result
  end

  it "should find 5 elements" do
    dictionary = ['a', 'b', 'c', 'ab', 'bc', 'abc', 'aab']
    target = 'aabc'
    result = find_possible_combinations(dictionary, target)
    expected = ['a abc', 'a a b c', 'a ab c']
    calculate_matches(result, expected).should == 5
    puts "==== should find 5 elements in result ===="
    puts result
  end

  it "should (second) return empty array" do
    dictionary = ['a', 'b', 'c', 'ab', 'bc', 'abc', 'aab']
    target = 'zabc'
    result = find_possible_combinations(dictionary, target)
    result.should have(0).things
  end

  it "should find 2 elements" do
    dictionary = ['za', 'b', 'c', 'ab', 'bc', 'abc', 'aab']
    target = 'zabc'
    result = find_possible_combinations(dictionary, target)
    expected = ['za b c', 'za bc']
    puts "==== should find 5 elements in result ===="
    puts result
    calculate_matches(result, expected).should == 2
  end
end