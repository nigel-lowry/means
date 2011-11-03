class Mean
  def Mean.arithmetic data
    sum = 0
    total = data.inject {|sum, v| sum + v}
    total / data.size
  end
end