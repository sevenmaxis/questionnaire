def find_possible_combinations(dictionary, target)
  result = []
  dictionary.sort! { |x, y| x.length <=> y.length }
  dictionary.length.times do
    internal_result = []
    str = String.new(target)
    dictionary.each do |word|
      while str.index(word) do
        internal_result << word
        str.sub!(word, '')
      end
    end

    if str.length == 0
      result << internal_result.sort.join(' ')
    end
    el = dictionary.shift
    dictionary.push(el)
  end
  result.uniq
end
=begin
def find_possible_combinations(dictionary, target)
  result = []
  1.upto(dictionary.length) do |size|
    permutation = dictionary.permutation(size).to_a
    permutation.each do |p|
      if p.join == target
        result << p.join(' ')
      end
    end
  end
  result
end
=end

#dictionary = ['za', 'b', 'c', 'ab', 'bc', 'abc', 'aab']
#target = 'zabc'
#result = find_possible_combinations(dictionary, target)
#puts result
#dictionary = ['a', 'b', 'c', 'ab', 'abc']
#target = 'aabc'
#puts find_possible_combinations(dictionary, target)
#dictionary = ['a', 'b', 'c', 'ab', 'bc', 'abc', 'aab']
#target = 'aabc'
#puts find_possible_combinations(dictionary, target)
=begin
target = 'aabcx'
puts find_possible_combinations(dictionary, target)
=end
