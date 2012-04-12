require 'mathn'

# Allows calculation of arithmetic, geometric and harmonic means.
# Class methods allow the passing in of a data set. 
# Alternatively an object can be created and elements can
# be added with #push
class Mean

  # Calculate the arithmetic mean
  # @param [Array<Numeric>] data the data values
  # @return [Numeric] the arithmetic mean
  def Mean.arithmetic(data)
    data.reduce(:+) / data.size unless data.empty?
  end

  # Calculate the geometric mean
  # @param (see Mean.arithmetic)
  # @return [Numeric] the geometric mean
  def Mean.geometric(data)
    data.reduce(:*) ** (1 / data.size) unless data.empty? or includes_zero_or_negative? data
  end

  # Calculate the harmonic mean
  # @param (see Mean.arithmetic)
  # @return [Numeric] the harmonic mean
  def Mean.harmonic(data)
    data.size / data.reduce(0) {|sum, element| sum += (1 / element)} unless data.empty? or includes_zero_or_negative? data
  end

  # Remember the initial state. 
  #
  # If you are passing in an initial state:
  # [arithmetic mean] needs `:sum` and `:count`
  # [geometric mean] needs `:product` and `:count`
  # [harmonic mean] needs `:sum_of_reciprocals` and `:count`
  # @param [Hash{Symbol => Numeric}]
  def initialize(params={})
    @sum                ||= params[:sum]                ||= 0
    @sum_of_reciprocals ||= params[:sum_of_reciprocals] ||= 0
    @product            ||= params[:product]            ||= 1
    @count              ||= params[:count]              ||= 0
    @includes_zero = false
  end

  # Add element to the data set
  # @param [Numeric] element the element to add
  def push(element)
    if element.zero?
      @includes_zero = true
    end

    @sum += element
    @sum_of_reciprocals += (1 / element) unless @includes_zero
    @product *= element unless @includes_zero
    @count += 1
  end

  # Calculate the arithmetic mean
  # @return [Numeric] the arithmetic mean
  def arithmetic_mean
    @sum / @count unless @count.zero?
  end

  # Calculate the geometric mean
  # @return [Numeric] the geometric mean
  def geometric_mean
    @product ** (1 / @count) unless @count.zero? or @includes_zero
  end

  # Calculate the harmonic mean
  # @return [Numeric] the harmonic mean
  def harmonic_mean
    @count / @sum_of_reciprocals unless @count.zero? or @includes_zero
  end

  private 

    def Mean.includes_zero_or_negative? data
      data.any? { |v| v <= 0 }
    end
end
