require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/../lib/app/helpers/rorext_helper.rb'
include RorextHelper

class RorextHelperTest < Test::Unit::TestCase
  def test_tweet
    assert_equal "Tweet! Hello", tweet("Hello")
  end
end