class DuplicatedFilenameChecker::Check
  def initialize(*survey_direcotry_roots)
    @survey_target_paths = survey_target_paths_by(survey_direcotry_roots)
  end

  def execute
    duplicate_paths.group_by(&:basename)
  end

  private

  # select duplicate paths from survey target paths
  def duplicate_paths
    @survey_target_paths.select do |file|
      is_duplicate?(file.basename)
    end
  end

  def is_duplicate?(basename)
    basename_with_count[basename] > 1
  end

  # @return [Hash] basename with same basename count.
  # @example { "basename_a.png" => 1, "basename_b.png" => 3, "basename_c.png" => 1 }
  def basename_with_count
    unless @basename_count.nil? # memorize
      return @basename_count
    end

    @basename_count = Hash.new(0)

    @survey_target_paths.each do |file|
      @basename_count[file.basename] += 1
    end

    @basename_count
  end

  def survey_target_paths_by(root_paths)
    # get paths in subdirectory
    paths = root_paths.map{|root| Dir.glob("#{root}/**/*.*") }.flatten

    # exchange to FileProfile
    paths.map{|path| DuplicatedFilenameChecker::FileProfile.new(path) }
  end
end