class Mean
  def Mean.arithmetic data
    data.reduce(:+) / data.size
  end
end