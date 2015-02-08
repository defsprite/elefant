require 'helper'
require 'elephant/stats'

class TestStats < PGTest

  describe "elephant" do

    before do
      @stats = Elephant::Stats.new
    end

    it "retrieves the activity stats" do
      assert_instance_of Array, @stats.get('activity')
    end

    it "retrieves the indices stats" do
      assert_instance_of Array, @stats.get('indices')
    end

    it "raises an ArgumentError if the query type is unknown" do
      assert_raises ArgumentError do
        @stats.get("totallyweirdunknownstatname")
      end
    end
  end
end
