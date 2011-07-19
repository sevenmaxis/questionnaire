
=begin
def find_possible_combinations(dictionary, target)
  result = []
  dictionary.each do |word|
    if target.index(word)
      internal_result = []
      str = String.new(target)
      internal_result << word
      str.sub!(word, '')
      dictionary.each do |w|
        while str.index(w) do
          internal_result << w
          str.sub!(w, '')
        end
      end
      if str.length == 0
        result << internal_result.join(' ')
      end
    end
  end
  result
end
=end
def find_possible_combinations(dictionary, target)
  result = []
  dictionary.sort! { |x,y| y.length <=> x.length}
  while dictionary.length > 0
    internal_result = []
    str = String.new(target)
    dictionary.each do |word|
      while str.index(word) do
        internal_result << word
        str.sub!(word, '')
      end
    end
    if str.length == 0
      result << internal_result.join(' ')
    end
    # shift all words which have this length
    length = dictionary.first.length
    dictionary.delete_if { |w| w.length == length}
  end
  result
end


=begin
dictionary = ['a', 'b', 'c', 'ab', 'abc']
target = 'aabc'
puts find_possible_combinations(dictionary, target)
target = 'aabcx'
puts find_possible_combinations(dictionary, target)
=end
