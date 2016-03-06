shared_examples_for "non-arithmetic means" do |mean_method|
  it "is nil when there are any zeroes" do
    data = [1.1, 0.0]
    expect(Mean.send(mean_method, data)).to be_nil
  end

  it "is nil when there are any negative numbers" do
    data = [1, -1]
    expect(Mean.send(mean_method, data)).to be_nil
  end
end