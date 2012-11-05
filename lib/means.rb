require 'mathn'

# Allows calculation of arithmetic, geometric and harmonic means.
# Class methods allow the passing in of a data set. 
# Alternatively an object can be created and elements can
# be added with #push
class Mean

  # Calculate the arithmetic mean
  # @param [Array<Numeric>] data the data values
  # @return [Numeric, nil] the arithmetic mean or nil if there is no data
  def Mean.arithmetic(data)
    data.reduce(:+) / data.size unless data.empty?
  end

  # Calculate the geometric mean
  # @param (see Mean.arithmetic)
  # @return [Numeric, nil] the geometric mean or nil if there is no data or any elements are zero or negative
  def Mean.geometric(data)
    data.reduce(:*) ** (1 / data.size) unless data.empty? or includes_zero_or_negative? data
  end

  # Calculate the harmonic mean
  # @param (see Mean.arithmetic)
  # @return [Numeric, nil] the harmonic mean or nil if there is no data or any elements are zero or negative
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
  # @raise if `:count` is negative
  # @raise if `:sum_of_reciprocals` is negative
  # @raise if `:product` is negative
  def initialize(params={})
    raise_error_for_negative params, :count
    raise_error_for_negative params, :sum_of_reciprocals
    raise_error_for_negative params, :product

    @sum                = params[:sum]                || 0
    @sum_of_reciprocals = params[:sum_of_reciprocals] || 0
    @product            = params[:product]            || 1
    @count              = params[:count]              || 0
    @includes_zero_or_negative = false
  end

  # Add element to the data set
  # @param [Numeric] element the element to add
  def push(element)
    @includes_zero_or_negative = true if Mean.zero_or_negative? element

    unless @includes_zero_or_negative
      @sum_of_reciprocals += (1 / element)
      @product *= element
    end

    @sum += element
    @count += 1
  end

  # Calculate the arithmetic mean
  # @return [Numeric, nil] the arithmetic mean or nil if there is no data
  def arithmetic_mean
    @sum / @count unless @count.zero?
  end

  # Calculate the geometric mean
  # @return [Numeric, nil] the geometric mean or nil if there is no data or any elements are zero or negative
  def geometric_mean
    @product ** (1 / @count) unless @count.zero? or @includes_zero_or_negative
  end

  # Calculate the harmonic mean
  # @return [Numeric, nil] the harmonic mean or nil if there is no data or any elements are zero or negative
  def harmonic_mean
    @count / @sum_of_reciprocals unless @count.zero? or @includes_zero_or_negative
  end

  private 

    def Mean.includes_zero_or_negative? data
      data.any? {|element| zero_or_negative? element}
    end

    def Mean.zero_or_negative? element
      element <= 0
    end

    def raise_error_for_negative params, key 
      raise %{cannot have negative "#{key.to_s}" of "#{params[key]}"} if params.has_key? key and params[key] < 0
    end
end
