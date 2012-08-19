require "spec_helper"

describe Movie do
  describe "all_ratings" do
    before do
      @count = 5
    end
    it "should return array" do
      Movie.all_ratings.should == ['G', 'PG', 'PG-13', 'NC-17', 'R']
    end
  end
end