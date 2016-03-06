shared_examples_for "all means" do |mean_method|
  it "is nil for an empty array" do
    expect(Mean.send(mean_method, [])).to be_nil
  end

  it "is the singleton element of a singleton array" do
    element = 5.5
    expect(Mean.send(mean_method, [element])).to eq(element)
  end

  it "is the common value in an array when all values are equal" do
    element = 5.5
    expect(Mean.send(mean_method, [element, element])).to eq(element)
  end
end