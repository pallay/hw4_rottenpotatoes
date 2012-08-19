require "spec_helper"

describe MoviesHelper do
  
  helper MoviesHelper
  
  describe "oddness" do
    context "for odd count" do
      before do
        @count = 5
      end
      it "should return the correct message" do
        helper.oddness(5).should == "odd"
      end
    end
    context "for even count" do
      before do
        @count = 6
      end
      it "should return the correct message" do
        helper.oddness(6).should == "even"
      end
    end
  end
end