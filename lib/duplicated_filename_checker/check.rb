require 'digest/md5'

class DuplicatedFilenameChecker::Check
  def initialize(*survey_direcotry_paths)
    @survey_direcotry_paths = survey_direcotry_paths.map{|path| File.absolute_path path }
  end

  def execute
    @file_paths = []
    @survey_direcotry_paths.each do |root|
      unless File.exist?(root)
        raise "No such file or directory: #{root}"
      end

      Dir.glob("#{root}/**/*.*").each do |path|
        @file_paths << DuplicatedFilenameChecker::FileProfile.new(path)
      end
    end

    # 重複を探す
    duplicate_file_paths = []

    @file_paths.each do |path|
      @file_base_names ||= @file_paths.map(&:basename) # メモ化

      if @file_base_names.count(path.basename) > 1 # duplicate
        duplicate_file_paths << path
      end
    end

    duplicate_file_paths.group_by(&:basename)
  end
end