require 'mathn'

# Allows calculation of arithmetic, geometric and harmonic means.
# Class methods allow the passing in of a data set. 
# Alternatively an object can be created and elements can
# be added with #push
class Mean

  # Calculate the arithmetic mean
  # @param [Array<Float>] data the data values
  # @return [Float] the arithmetic mean
  def Mean.arithmetic(data)
    data.reduce(:+) / data.size unless data.empty?
  end

  # Calculate the geometric mean
  # @param (see Mean.arithmetic)
  # @return [Float] the geometric mean
  def Mean.geometric(data)
    data.reduce(:*) ** (1 / data.size) unless data.empty?
  end

  # Calculate the harmonic mean
  # @param (see Mean.arithmetic)
  # @return [Float] the harmonic mean
  def Mean.harmonic(data)
    data.size / data.reduce(0) {|sum, element| sum += (1 / element)} unless data.empty?
  end

  # Remember the initial state. 
  #
  # If you are passing in an initial state:
  # [arithmetic mean] needs `:sum` and `:count`
  # [geometric mean] needs `:product` and `:count`
  # [harmonic mean] needs `:sum_of_reciprocals` and `:count`
  # @param [Hash{Symbol => Fixnum}]
  def initialize(params={})
    @sum                ||= params[:sum]                ||= 0
    @sum_of_reciprocals ||= params[:sum_of_reciprocals] ||= 0
    @product            ||= params[:product]            ||= 1
    @count              ||= params[:count]              ||= 0
  end

  # Add element to the data set
  # @param [Float] element the element to add
  def push(element)
    @sum += element
    @sum_of_reciprocals += (1 / element)
    @product *= element
    @count += 1
  end

  # Calculate the arithmetic mean
  # @return [Float] the arithmetic mean
  def arithmetic_mean
    @sum / @count unless @count == 0
  end

  # Calculate the geometric mean
  # @return [Float] the geometric mean
  def geometric_mean
    @product ** (1 / @count) unless @count == 0
  end

  # Calculate the harmonic mean
  # @return [Float] the harmonic mean
  def harmonic_mean
    @count / @sum_of_reciprocals unless @count == 0
  end
end