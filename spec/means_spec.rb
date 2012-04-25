require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

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

shared_examples_for "non-arithmetic means" do
  [:geometric, :harmonic].each do |mean|
    it "is nil when there are any zeroes" do
      data = [1.1, 2.2, 0.0]
      Mean.send(mean, data).should be_nil
    end

    it "is nil when there are any negative numbers" do
      data = [1, -1]
      Mean.send(mean, data).should be_nil
    end
  end
end

describe "Mean" do

  describe ".arithmetic" do
    it_behaves_like "all means"

    specify { Mean.arithmetic([1.0, 2.0]).should be_within(0.01).of(1.5) }
    specify { Mean.arithmetic([1, 2]).should be_within(0.01).of(1.5) }
    specify { Mean.arithmetic([1, 2.0]).should be_within(0.01).of(1.5) }
    specify { Mean.arithmetic([1.0, 2]).should be_within(0.01).of(1.5) }

    specify { Mean.arithmetic([1, 2, 3]).should == 2 }
    
    specify { Mean.arithmetic([0, 2]).should == 1 }
    specify { Mean.arithmetic([-1, 3]).should == 1 }
  end

  describe ".geometric" do
    it_behaves_like "all means"
    it_behaves_like "non-arithmetic means"

    it "is the square root of the product of two numbers" do
      d1, d2 = 2, 8
      data = [d1, d2]
      Mean.geometric(data).should == Math.sqrt(d1 * d2)
    end

    it "is the cube root of the product of three numbers" do
      d1, d2, d3 = 4, 1, 1.0 / 32.0
      data = [d1, d2, d3]
      Mean.geometric(data).should == Math.cbrt(d1 * d2 * d3)
    end
  end

  describe ".harmonic" do
    it_behaves_like "all means"
    it_behaves_like "non-arithmetic means"

    it "is according to the formula with two elements" do
      d1, d2 = 1.0, 2.0
      data = [d1, d2]
      Mean.harmonic(data).should be_within(0.01).of((2.0 * d1 * d2) / (d1 + d2))
    end

    it "is 12/7 for [1, 2, 4]" do
      data = [1.0, 2.0, 4.0]
      Mean.harmonic(data).should be_within(0.01).of(12/7)
    end
  end

  describe "accumulators" do
    before(:each) do
      @m = Mean.new()
    end

    describe "#arithmetic_mean" do
      it "accumulates the arithmetic mean" do
        @m.arithmetic_mean.should be_nil
        @m.push 1
        @m.arithmetic_mean.should == 1
        @m.push 2
        @m.arithmetic_mean.should == 1.5
        @m.push 3
        @m.arithmetic_mean.should == 2
        @m.push 0
        @m.arithmetic_mean.should == 1.5
        @m.push -1
        @m.arithmetic_mean.should == 1
      end
    end

    describe "#geometric_mean" do
      it "accumulates the geometric mean until zero" do
        @m.geometric_mean.should be_nil
        @m.push 2
        @m.geometric_mean.should == 2
        @m.push 8
        @m.geometric_mean.should == 4
        @m.push 0
        @m.geometric_mean.should be_nil
      end

      it "accumulates the geometric mean until negative" do
        @m.geometric_mean.should be_nil
        @m.push 2
        @m.geometric_mean.should == 2
        @m.push 8
        @m.geometric_mean.should == 4
        @m.push -1
        @m.geometric_mean.should be_nil
      end
    end

    describe "#harmonic_mean" do
      it "accumulates the harmonic mean until zero" do
        @m.harmonic_mean.should be_nil
        @m.push 1
        @m.harmonic_mean.should == 1
        @m.push 2
        @m.harmonic_mean.should == 4.0 / 3.0
        @m.push 0
        @m.harmonic_mean.should be_nil
      end

      it "accumulates the harmonic mean until negative" do
        @m.harmonic_mean.should be_nil
        @m.push 1
        @m.harmonic_mean.should == 1
        @m.push 2
        @m.harmonic_mean.should == 4.0 / 3.0
        @m.push -1
        @m.harmonic_mean.should be_nil
      end
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

    it "rejects a negative count" do
      lambda { Mean.new(count: -1) }.should raise_error
    end

    it "rejects negative sum of reciprocals" do
      lambda { Mean.new(sum_of_reciprocals: -1) }.should raise_error
    end

    it "rejects negative product" do
      lambda { Mean.new(product: -1) }.should raise_error
    end
  end
end
