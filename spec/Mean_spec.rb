require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Mean" do

  describe ".arithmetic" do
    it "is nil for an empty array" do
      Mean.arithmetic([]).should be_nil
    end

    it "is the singleton element of a singleton array" do
      element = 5.5
      Mean.arithmetic([element]).should == element
    end

    it "is the common value in an array when all values are equal" do
      element = 5.5
      Mean.arithmetic([element, element]).should == element
    end

    it "is 1.5 for [1, 2]" do 
      data = [1.0, 2.0]
      Mean.arithmetic(data).should be_within(0.01).of(1.5)
    end

    it "works with integers" do
      data = [1, 2]
      Mean.arithmetic(data).should be_within(0.01).of(1.5) 
    end

    it "works with an int then a float" do
      data = [1, 2.0]
      Mean.arithmetic(data).should be_within(0.01).of(1.5) 
    end

    it "works with a float then an int" do
      data = [1.0, 2]
      Mean.arithmetic(data).should be_within(0.01).of(1.5) 
    end

    it "works with three numbers" do
      data = [1, 2, 3]
      Mean.arithmetic(data).should == 2
    end
  end

  describe ".geometric" do
    it "is nil for an empty array" do
      Mean.geometric([]).should be_nil
    end

    it "is the singleton element of a singleton array" do
      element = 5.5
      Mean.geometric([element]).should == element
    end

    it "is the common value in a when all values are equal" do
      element = 5.5
      Mean.geometric([element, element]).should == element
    end

    it "is zero when there is even a single zero" do
      data = [1.1, 2.2, 0.0]
      Mean.geometric(data).should == 0
    end

    it "is the square root of the product of two numbers" do
      d1, d2 = 2, 8
      data = [d1, d2]
      Mean.geometric(data).should == 4
    end

    it "is the cube root of the product of three numbers" do
      d1, d2, d3 = 4, 1, 1.0 / 32.0
      data = [d1, d2, d3]
      Mean.geometric(data).should == 1.0 / 2.0
    end
  end

  describe ".harmonic" do
    it "is nil for an empty array" do
      Mean.harmonic([]).should be_nil
    end

    it "is the singleton element of a singleton array" do
        element = 5.5
        Mean.harmonic([element]).should == element
    end

    it "is the common value in a when all values are equal" do
      element = 5.5
      Mean.harmonic([element, element]).should == element
    end

    it "is according to the formula with two elements" do
      d1, d2 = 1.0, 2.0
      data = [d1, d2]
      Mean.harmonic(data).should be_within(0.01).of((2.0 * d1 * d2) / (d1 + d2))
    end

    it "is 12/7 for [1, 2, 4]" do
      data = [1.0, 2.0, 4.0]
      Mean.harmonic(data).should be_within(0.01).of(1.7142)
    end

    it "is zero if there is even one zero" do 
      data = [1.0, 2.0, 0.0]
      Mean.harmonic(data).should == 0
    end
  end

  describe "accumulators" do
    before(:each) do
      @m = Mean.new()
    end

    it "accumulates the arithmetic mean" do
      @m.arithmetic_mean.should be_nil
      @m.push 1
      @m.arithmetic_mean.should == 1
      @m.push 2
      @m.arithmetic_mean.should == 1.5
      @m.push 3
      @m.arithmetic_mean.should == 2
    end

    it "accumulates the geometric mean" do
      @m.geometric_mean.should be_nil
      @m.push 2
      @m.geometric_mean.should == 2
      @m.push 8
      @m.geometric_mean.should == 4
    end

    it "accumulates the harmonic mean" do
      @m.harmonic_mean.should be_nil
      @m.push 1
      @m.harmonic_mean.should == 1
      @m.push 2
      @m.harmonic_mean.should == 4.0 / 3.0
    end
  end

  describe "initialising accumulator" do
    it "resurrects the arithmetic mean using the count and sum" do
      m = Mean.new(count: 1, sum: 1)
      m.arithmetic_mean.should == 1
      m.push 2
      m.arithmetic_mean.should == 1.5
    end

    it "resurrects the geometric mean using the count and product" do
      m = Mean.new(count: 1, product: 2)
      m.geometric_mean.should == 2
      m.push 8
      m.geometric_mean.should == 4
    end

    it "resurrects the harmonic mean using the count and sum of the reciprocals" do
      m = Mean.new(count: 1, sum_of_reciprocals: 1)
      m.harmonic_mean.should == 1
      m.push 2
      m.harmonic_mean.should == 4.0 / 3.0
    end
  end
end
