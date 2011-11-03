require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Mean" do

  describe "#arithmetic" do
    it "should be 500.5 for [1, 1000]" do 
      data = [1.0, 1000.0]
      Mean.arithmetic(data).should be_close(500.5, 0.05)
    end

    it "should work with integers too"
  end
end
