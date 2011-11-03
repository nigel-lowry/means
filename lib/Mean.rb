class Mean
  def Mean.arithmetic data
    sum = 0
    data.each {|v| sum += v}
    sum / data.size
  end
end