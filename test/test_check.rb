require 'minitest_helper'

class TestCheck < MiniTest::Unit::TestCase
  def setup
    survey_dir_path_1 = './sample_for_test/dir_a1'
    survey_dir_path_2 = './sample_for_test/dir_b1'

    @check = DuplicatedFilenameChecker::Check.new(survey_dir_path_1, survey_dir_path_2)
  end

  def test_initialize
    assert true
  end
end
