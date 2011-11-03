class Mean
  def Mean.arithmetic data
    data.reduce(:+) / data.size
  end

  def Mean.geometric data
    product = data.reduce(:*)
    product ** (1.0 / data.size)
  end
end