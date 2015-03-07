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

  private

  def duplicate_file_profiles_with_filter
    unless @exclude_basename_regexp
      return @duplicate_file_profiles
    end

    @duplicate_file_profiles.select do |basename, _|
      !basename =~ Regexp.new(@exclude_basename_regexp)
    end
  end
end