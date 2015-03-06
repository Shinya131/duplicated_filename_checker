require 'minitest_helper'

class TestFileProfile < MiniTest::Unit::TestCase
  def setup
    @file_profile = DuplicatedFilenameChecker::FileProfile.new
  end

  def test_it_does_something_useful
    assert true
  end
end
