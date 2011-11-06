require 'mathn'

# Allows calculation of arithmetic, geometric and harmonic means.
# Class methods allow the passing in of a data set. 
# Alternatively an object can be created and elements can
# be added with Mean#push
class Mean

  # Calculate the arithmetic mean of _data_
  def Mean.arithmetic(data)
    data.reduce(:+) / data.size unless data.empty?
  end

  # Calculate the geometric mean of _data_
  def Mean.geometric(data)
    data.reduce(:*) ** (1 / data.size) unless data.empty?
  end

  # Calculate the harmonic mean of _data_
  def Mean.harmonic(data)
    data.size / data.reduce(0) {|sum, element| sum += (1 / element)} unless data.empty?
  end

  # Remember the initial state. 
  #
  # If you are passing in an initial state:
  # [arithmetic mean] needs :sum and :count
  # [geometric mean] needs :product and :count.
  # [harmonic mean] needs :sum_of_reciprocals and :count
  def initialize(params={})
    @sum                ||= params[:sum]                ||= 0
    @sum_of_reciprocals ||= params[:sum_of_reciprocals] ||= 0
    @product            ||= params[:product]            ||= 1
    @count              ||= params[:count]              ||= 0
  end

  # Add _element_ to the data set
  def push(element)
    @sum += element
    @sum_of_reciprocals += (1 / element)
    @product *= element
    @count += 1
  end

  # Calculate the arithmetic mean of the data set
  def arithmetic_mean
    @sum / @count unless @count == 0
  end

  # Calculate the geometric mean of the data set
  def geometric_mean
    @product ** (1 / @count) unless @count == 0
  end

  # Calculate the harmonic mean of the data set
  def harmonic_mean
    @count / @sum_of_reciprocals unless @count == 0
  end
end