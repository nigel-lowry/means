class Mean
  def Mean.arithmetic data
    data.reduce(:+) / data.size
  end

  def Mean.geometric data
    data.reduce(:*) ** (1.0 / data.size)
  end

  def Mean.harmonic data
    data.size / data.reduce(0) {|sum, element| sum += (1.0 / element)}
  end
end