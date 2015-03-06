require 'minitest_helper'

class TestFileProfile < MiniTest::Unit::TestCase
  def setup
    @file_profile = DuplicatedFilenameChecker::FileProfile.new('./sample_for_test/dir_a1/duplicate_filename.sample')
  end

  def test_basename
    assert @file_profile.basename == 'duplicate_filename.sample'
  end
end
