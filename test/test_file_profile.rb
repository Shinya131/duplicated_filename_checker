require 'minitest_helper'

class TestFileProfile < MiniTest::Unit::TestCase
  def setup
    @sample_filename      = 'duplicate_filename.sample'
    @sample_relative_path = File.join('./test/sample_for_test/dir_a1/', @sample_filename)
    @sample_fullpath      = File.join(test_fullpath, 'sample_for_test/dir_a1/', @sample_filename)

    @file_profile = DuplicatedFilenameChecker::FileProfile.new(@sample_relative_path)
  end

  def test_basename
    assert @file_profile.basename == @sample_filename
  end

  def test_path
    assert @file_profile.path == @sample_fullpath
  end
end
