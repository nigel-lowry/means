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

  def initialize(params = {})
    @sum = params[:sum]
    @sum_of_reciprocals = params[:sum_of_reciprocals]
    @product = params[:product]
    @count = params[:count]

    @sum ||= 0
    @sum_of_reciprocals ||= 0
    @product ||= 1
    @count ||= 0
  end

  def push element
    @sum += element
    @sum_of_reciprocals += (1 / element)
    @product *= element
    @count += 1
  end

  def arithmetic_mean
    @sum / @count unless @count == 0
  end

  def geometric_mean
    @product ** (1 / @count) unless @count == 0
  end

  def harmonic_mean
    @count / @sum_of_reciprocals unless @count == 0
  end
end