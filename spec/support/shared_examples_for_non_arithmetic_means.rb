shared_examples_for "non-arithmetic means" do
  [:geometric, :harmonic].each do |mean|
    it "is nil when there are any zeroes" do
      data = [1.1, 0.0]
      Mean.send(mean, data).should be_nil
    end

    it "is nil when there are any negative numbers" do
      data = [1, -1]
      Mean.send(mean, data).should be_nil
    end
  end
end