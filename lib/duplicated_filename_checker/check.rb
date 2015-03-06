class DuplicatedFilenameChecker::Check
  def initialize(*survey_direcotry_roots)
    set_survey_target_paths_by!(survey_direcotry_roots)
  end

  def execute
    duplicate_paths.group_by(&:basename)
  end

  private

  def duplicate_paths
    @survey_target_paths.select do |path|
      is_duplicate?(path.basename)
    end
  end

  def is_duplicate?(basename)
    survey_paths_basename_list.count(basename) > 1
  end

  # baseames of survey_paths. it list is not uniq.
  # @example ['basename1', 'basename1', 'basename2', 'basename3']
  def survey_paths_basename_list
    @basename_list ||= @survey_target_paths.map(&:basename) #memorize
  end

  def set_survey_target_paths_by!(root_paths)
    paths = survey_paths_by(root_paths)
    @survey_target_paths = paths.map{|path| to_file_profile(path) }
  end

  def survey_paths_by(survey_direcotry_roots)
    survey_direcotry_roots.map do |root|
      Dir.glob("#{root}/**/*.*")
    end.flatten
  end

  def to_file_profile(path)
    DuplicatedFilenameChecker::FileProfile.new(path)
  end
end