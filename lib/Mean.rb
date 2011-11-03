class Mean
  def Mean.arithmetic data
    data.reduce(:+) / data.size
  end

  def Mean.geometric data
    data.reduce(:*) ** (1.0 / data.size)
  end

  def Mean.harmonic data
    sum = 0
    data.each {|v| sum += (1.0 / v)}
    data.size / sum
  end
end