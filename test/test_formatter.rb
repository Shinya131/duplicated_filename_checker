require 'minitest_helper'

describe DuplicatedFilenameChecker::Formatter do
  before do
    survey_dir_path_1 = './test/sample_for_test/dir_a1'
    survey_dir_path_2 = './test/sample_for_test/dir_b1'
    @sample_filename  = 'duplicate_filename_1.sample'

    @check_result = DuplicatedFilenameChecker::Check.new(survey_dir_path_1, survey_dir_path_2).execute
    @formatter = DuplicatedFilenameChecker::Formatter.new(@check_result)
  end

  describe '#hash' do
    it 'like plain result' do
      assert @formatter.hash == @check_result
    end
  end

  describe '#only_basename' do
    it 'show only basenames' do
      assert @formatter.only_basename == ['duplicate_filename_1.sample', 'duplicate_filename_2.png']
    end
  end

  describe '#markdown' do
    it 'first line has ##' do
      first_line = @formatter.markdown.split("\n")[0]
      assert first_line =~ /##/
    end

    it 'first line has basname' do
      first_line = @formatter.markdown.split("\n")[0]
      assert first_line =~ /#{@sample_filename}/
    end

    it 'second line has path' do
      second_line = @formatter.markdown.split("\n")[1]
      duplicate_file_list = @check_result.values.first
      assert duplicate_file_list.any?{|file| second_line =~ /#{file.path}/ }
    end
  end

  describe '#exclude_basename' do
    before do
      @formatter.exclude_basename('.sample')
    end

    it 'ignored specified basename' do
      assert @formatter.only_basename == ['duplicate_filename_2.png']
      assert @formatter.hash.keys == ['duplicate_filename_2.png']
    end
  end
end
