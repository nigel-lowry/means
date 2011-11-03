require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Mean" do

  describe "#arithmetic" do
    it "should be 500.5 for [1, 1000]" do 
      Mean.arithmetic[1, 1000].should be_close(500.5, 0.05)
    end
  end
end
