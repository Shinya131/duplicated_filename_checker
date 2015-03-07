class DuplicatedFilenameChecker::Formatter
  def initialize(result_of_duplicate_filename_checker_check_execute)
    @duplicate_file_profiles = result_of_duplicate_filename_checker_check_execute
  end

  def exclude_basename(exclude_basename_regexp)
    @exclude_basename_regexp = exclude_basename_regexp
  end

  def hash
    duplicate_file_profiles_with_filter
  end

  def only_basename
    duplicate_file_profiles_with_filter.keys
  end

  # @example
  # ### duplicate_filename.sample
  # 1. /Users/nagai_shinya/gem/duplicated_filename_checker/test/sample_for_test/dir_a1/duplicate_filename.sample
  #  * md5: 5258bf47639b8f906c1a17aee86c54dd
  #  * mtime: 2015-03-07 13:44:05 +0900
  #
  # 2. /Users/nagai_shinya/gem/duplicated_filename_checker/test/sample_for_test/dir_b1/dir_b2/duplicate_filename.sample
  #  * md5: 5258bf47639b8f906c1a17aee86c54dd
  #  * mtime: 2015-03-07 13:44:05 +0900
  def markdown
    duplicate_file_profiles_with_filter.map do |basename, duplicate_file_profiles|
      [
        "## #{basename}\n",
        "#{file_profile_to_markdown(duplicate_file_profiles)}",
      ]
    end.flatten.join
  end

  private

  def duplicate_file_profiles_with_filter
    unless @exclude_basename_regexp
      return @duplicate_file_profiles
    end

    @duplicate_file_profiles.select do |basename, _|
      !basename =~ Regexp.new(@exclude_basename_regexp)
    end
  end

  def file_profile_to_markdown(duplicate_file_profiles)
    duplicate_file_profiles.map.with_index(1) do |file_profile, index|
      [
        "#{index}. #{file_profile.path}\n",
        " * md5: #{file_profile.md5_digest}\n",
        " * mtime: #{file_profile.stat.mtime}\n",
        "\n"
      ]
    end.join
  end
end