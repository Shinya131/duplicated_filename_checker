require 'minitest_helper'

describe DuplicatedFilenameChecker::Formatter do
  before do
    survey_dir_path_1 = './test/sample_for_test/dir_a1'
    survey_dir_path_2 = './test/sample_for_test/dir_b1'
    @sample_filename  = 'duplicate_filename.sample'

    @check_result = DuplicatedFilenameChecker::Check.new(survey_dir_path_1, survey_dir_path_2).execute
    @formatter = DuplicatedFilenameChecker::Formatter.new(@check_result)
  end

  describe '#only_basename' do
    it 'result only duplicate basename' do
      assert @formatter.only_basename == ['duplicate_filename.sample']
    end
  end
end
