require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Mean" do

  describe "#arithmetic" do
    it "should be nil for an empty array" do
      Mean.arithmetic([]).should be_nil
    end

    it "should be the singleton element of a singleton array" do
      element = 5.5
      Mean.arithmetic([element]).should == element
    end

    it "should be the common value in an array when all values are equal" do
      element = 5.5
      Mean.arithmetic([element, element]).should == element
    end

    it "should be 1.5 for [1, 2]" do 
      data = [1.0, 2.0]
      Mean.arithmetic(data).should be_within(0.01).of(1.5)
    end

    it "should work with integers" do
      data = [1, 2]
      Mean.arithmetic(data).should be_within(0.01).of(1.5) 
    end

    it "should work with an int then a float" do
      data = [1, 2.0]
      Mean.arithmetic(data).should be_within(0.01).of(1.5) 
    end

    it "should work with a float then an int" do
      data = [1.0, 2]
      Mean.arithmetic(data).should be_within(0.01).of(1.5) 
    end
  end

  describe "#geometric" do
    it "should be nil for an empty array" do
      Mean.geometric([]).should be_nil
    end

    it "should be the singleton element of a singleton array" do
        element = 5.5
        Mean.geometric([element]).should == element
    end

    it "should be the common value in a when all values are equal" do
      element = 5.5
      Mean.geometric([element, element]).should == element
    end

    it "should be zero when there is even a single zero" do
      data = [1.1, 2.2, 0.0]
      Mean.geometric(data).should == 0.0
    end

    it "should be 31.622 for [1, 1000]" do
      data = [1.0, 1000.0]
      Mean.geometric(data).should be_within(0.005).of(31.622)
    end
  end

  describe "#harmonic" do
    it "should be be according to the formula with two elements" do
      d1, d2 = 1.0, 2.0
      data = [d1, d2]
      Mean.harmonic(data).should be_within(0.01).of((2.0 * d1 * d2) / (d1 + d2))
    end

    it "should be the common value in an array when all values are equal" do
      element = 5.5
      Mean.harmonic([element, element]).should == element
    end


    it "should be 12/7 for [1, 2, 4]" do
      data = [1.0, 2.0, 4.0]
      Mean.harmonic(data).should be_within(0.01).of(1.7142)
    end

    it "should do something when the array contains zeroes"
  end
end
