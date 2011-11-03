require 'mathn'

class Mean
  def Mean.arithmetic data
    data.reduce(:+) / data.size unless data.empty?
  end

  def Mean.geometric data
    data.reduce(:*) ** (1 / data.size) unless data.empty?
  end

  def Mean.harmonic data
    data.size / data.reduce(0) {|sum, element| sum += (1 / element)} unless data.empty?
  end

  def initialize
    @sum = 0
    @count = 0
    @product = 1
  end

  def push element
    @sum += element
    @product *= element
    @count += 1
  end

  def arithmetic_mean
    @sum / @count unless @count == 0
  end

  def geometric_mean
    @product ** (1 / @count) unless @count == 0
  end

end