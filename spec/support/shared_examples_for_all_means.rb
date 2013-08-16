shared_examples_for "all means" do
  [:arithmetic, :geometric, :harmonic].each do |mean|
    it "is nil for an empty array" do
      Mean.send(mean, []).should be_nil
    end

    it "is the singleton element of a singleton array" do
      element = 5.5
      Mean.send(mean, [element]).should == element
    end

    it "is the common value in an array when all values are equal" do
      element = 5.5
      Mean.send(mean, [element, element]).should == element
    end
  end
end