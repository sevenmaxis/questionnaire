Item = Struct.new(:word, :count)

def find_counts(array)
  result = []
  class << result
    def <<(val)
      new_val = true
      self.each do |el|
        if el.word == val
          el.count += 1
          new_val = false
          break
        end
      end
      super(Item.new(val, 1)) if new_val
    end
  end
  array.each { |a| result << a }

  result.sort do |x, y|
    if  x.count == y.count # For items with equal count attribute order
      x.word <=> y.word # order by word in in alphabetical order
    else
      y.count <=> x.count # order by count in descending order
    end
  end
end

#puts find_counts(['abc', 'xyz', 'def', 'xyz', 'abc'])
#puts find_counts([ 'c', 'b', 'a'])
