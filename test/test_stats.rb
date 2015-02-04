require './test_helper'
require 'elephant/stats'

class TestStats < PGTest

  describe "elephant" do

    before do
      @stats = Elephant::Stats.new
    end

    it "should retrieve the activity stats" do
      assert_instance_of Array, @stats.get('activity')
    end

    it "should retrieve the indices stats" do
      assert_instance_of Array, @stats.get('indices')
    end

    it "should raise an ArgumentError if the query type is unknown" do
      assert_raises ArgumentError do
        @stats.get("totallyweirdunknownstatname")
      end
    end
  end
end
