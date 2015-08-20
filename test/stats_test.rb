require "test_helper"
require "elefant/stats"

class StatsTest < PGTest

  def setup
    super
    @stats = Elefant::Stats.new
  end

  def test_retrieves_activity
    result = @stats.get("activity", [])

    assert_instance_of Array, result
    refute_empty result
  end

  def test_retrieves_user_indices
    result = @stats.get("user_indexes", [])

    assert_instance_of Array, result
    refute_empty result
    assert_equal "elefant_test_models", result[0]["rel_name"]
  end

  def test_raises_for_unknown
    assert_raises ArgumentError do
      @stats.get("totallyweirdunknownstatname")
    end
  end
end

