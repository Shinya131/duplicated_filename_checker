require 'minitest_helper'

class TestCheck < MiniTest::Unit::TestCase
  describe DuplicatedFilenameChecker::Check do
    describe '#execute' do
      describe 'survey target has duplicate basename files' do
        before do
          survey_dir_path_1 = './test/sample_for_test/dir_a1'
          survey_dir_path_2 = './test/sample_for_test/dir_b1'
          @sample_filename  = 'duplicate_filename.sample'

          @check = DuplicatedFilenameChecker::Check.new(survey_dir_path_1, survey_dir_path_2)
          @check_result = @check.execute
        end

        it 'key is duplicate filename' do
          basename = @check_result.keys.first
          assert basename == @sample_filename
        end

        it 'value is duplicate file profiles' do
          profiles = @check_result.values.first

          assert profiles.all?{ |path| path.class == DuplicatedFilenameChecker::FileProfile }
          assert profiles.all?{ |path| path.basename == @sample_filename } # all basename is same
          assert profiles.map(&:path) == profiles.map(&:path).uniq        # all path is different
        end
      end
    end
  end
end
