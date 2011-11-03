class Mean
  def Mean.arithmetic data
    sum = 0
    data.reduce(:+) / data.size
  end
end