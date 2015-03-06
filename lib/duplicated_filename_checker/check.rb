class DuplicatedFilenameChecker::Check
  def initialize(*survey_direcotry_roots)
    @survey_target_paths =  survey_target_paths_by(survey_direcotry_roots)
  end

  def execute
    duplicate_paths.group_by(&:basename)
  end

  private

  # select duplicate paths from survey target paths
  def duplicate_paths
    @survey_target_paths.select do |path|
      is_duplicate?(path.basename)
    end
  end

  def is_duplicate?(basename)
    survey_paths_basename_list.count(basename) > 1
  end

  # Baseames of survey_paths. It list is not uniq.
  # @example ['basename1', 'basename1', 'basename2', 'basename3']
  def survey_paths_basename_list
    @basename_list ||= @survey_target_paths.map(&:basename) #memorize
  end

  def survey_target_paths_by(root_paths)
    # get paths in subdirectory
    paths = root_paths.map{|root| Dir.glob("#{root}/**/*.*") }.flatten

    # exchange to FileProfile
    paths.map{|path| DuplicatedFilenameChecker::FileProfile.new(path) }
  end
end