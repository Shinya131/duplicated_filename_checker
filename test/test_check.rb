require 'minitest_helper'

describe DuplicatedFilenameChecker::Check do
  describe '#initialize' do

    describe 'arguments no given.' do
      it 'raise' do
        assert_raises(ArgumentError){ DuplicatedFilenameChecker::Check.new }
      end
    end

    describe 'survey target  directory is no exists.' do
      it 'raise' do
        assert_raises(ArgumentError){ DuplicatedFilenameChecker::Check.new('/not_exists_dir') }
      end
    end
  end

  describe '#execute' do
    describe 'survey target has duplicate basename files' do
      before do
        survey_dir_path_1 = './test/sample_for_test/dir_a1'
        survey_dir_path_2 = './test/sample_for_test/dir_b1'
        @sample_filenames = ['duplicate_filename_1.sample', 'duplicate_filename_2.png']

        @check = DuplicatedFilenameChecker::Check.new(survey_dir_path_1, survey_dir_path_2)
        @check_result = @check.execute
      end

      it 'key is duplicate filename' do
        assert @check_result.keys.any?{|basename| @sample_filenames.include? basename }
      end

      describe 'value is duplicate file profiles' do
        before do
          @profiles = @check_result.values
        end

        it 'prfiles is DuplicatedFilenameChecker::FileProfile' do
          @profiles.flatten.each do |path|
            assert path.class == DuplicatedFilenameChecker::FileProfile
          end
        end

        it 'proflies.first all basename is same' do
          @profiles.flatten.each do |path|
            assert @sample_filenames.include? path.basename
          end
        end

        it 'proflies.first path is different' do
          paths = @profiles.flatten.map(&:path)
          assert paths == paths.uniq
        end
      end
    end

    describe 'survey target has not duplicate basename file' do
      before do
        @check = DuplicatedFilenameChecker::Check.new('./test/sample_for_test/dir_a1')
        @check_result = @check.execute
      end

      it 'result is empty hash' do
        assert @check_result == {}
      end
    end
  end
end
