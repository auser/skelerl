class Array
  def contains_similar_elements? other
    !(self & other).empty?
  end
end