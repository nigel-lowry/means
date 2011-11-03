class Mean
  def Mean.arithmetic data
    sum = 0
    total = data.reduce {|sum, v| sum + v}
    total / data.size
  end
end