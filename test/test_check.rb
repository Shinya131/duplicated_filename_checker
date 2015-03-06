require 'minitest_helper'

class TestCheck < MiniTest::Unit::TestCase
  def setup
    survey_dir_path_1 = './test/sample_for_test/dir_a1'
    survey_dir_path_2 = './test/sample_for_test/dir_b1'
    @sample_filename  = 'duplicate_filename.sample'

    @check = DuplicatedFilenameChecker::Check.new(survey_dir_path_1, survey_dir_path_2)
  end

  def test_execute
    duplicate_file_paths = @check.execute

    assert(duplicate_file_paths.class == Hash)

    # key is duplicate filename
    basename = duplicate_file_paths.keys.first
    assert(basename == @sample_filename)

    # value is duplicate file paths
    filepaths = duplicate_file_paths.values.first

    assert filepaths.all?{ |path| path.class == DuplicatedFilenameChecker::FileProfile }
    assert filepaths.all?{ |path| path.basename == @sample_filename } # all basename is same
    assert filepaths.map(&:path) == filepaths.map(&:path).uniq        # all path is different
  end
end
