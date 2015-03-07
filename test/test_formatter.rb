require 'minitest_helper'

class TestCheck < MiniTest::Unit::TestCase
  def setup
    survey_dir_path_1 = './test/sample_for_test/dir_a1'
    survey_dir_path_2 = './test/sample_for_test/dir_b1'
    @sample_filename  = 'duplicate_filename.sample'

    @check_result = DuplicatedFilenameChecker::Check.new(survey_dir_path_1, survey_dir_path_2).execute
    @formatter = DuplicatedFilenameChecker::Formatter.new(@check_result)
  end

  def test
    assert true
  end

  # def test_only_basename
  #   assert @formatter.only_basename == ['duplicatefilename.sample']
  # end
end
