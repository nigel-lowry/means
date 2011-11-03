class Mean
  def Mean.arithmetic data
    sum = 0
    total = data.reduce(:+)
    total / data.size
  end
end