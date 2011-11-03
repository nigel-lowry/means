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
end