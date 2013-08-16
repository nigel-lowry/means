shared_examples_for "all means" do |mean_method|
  it "is nil for an empty array" do
    Mean.send(mean_method, []).should be_nil
  end

  it "is the singleton element of a singleton array" do
    element = 5.5
    Mean.send(mean_method, [element]).should == element
  end

  it "is the common value in an array when all values are equal" do
    element = 5.5
    Mean.send(mean_method, [element, element]).should == element
  end
end