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

