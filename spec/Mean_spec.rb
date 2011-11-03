require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Mean" do

  describe "#arithmetic" do
    it "should be 500.5 for [1, 1000]" do 
      data = [1.0, 1000.0]
      Mean.arithmetic(data).should be_within(0.05).of(500.5)
    end

    it "should work with integers too"
    it "should work with a mix of ints and floats"
    it "should work with empty array"
    it "should work with singleton array"
  end

  describe "#geometric" do
    it "should be 31.622 for [1, 1000]" do
      data = [1.0, 1000.0]
      Mean.geometric(data).should be_within(0.005).of(31.622)
    end

    it "should do something when the array contains zeroes"
  end

  describe "#harmonic" do
    it "should be 12/7 for [1, 2, 4]" do
      data = [1.0, 2.0, 4.0]
      Mean.harmonic(data).should be_within(0.01).of(12.0 / 7.0)
    end

    it "should do something when the array contains zeroes"
  end
end
