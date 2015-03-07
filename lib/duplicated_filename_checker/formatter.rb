class DuplicatedFilenameChecker::Formatter
  def initialize(result_of_duplicate_filename_checker_check_execute)
    @duplicate_file_profiles = result_of_duplicate_filename_checker_check_execute
  end

  def only_basename
    @duplicate_file_profiles.keys
  end
end