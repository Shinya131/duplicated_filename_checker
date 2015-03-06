class DuplicatedFilenameChecker::FileProfile
  def initialize(file_path)
    @file_path = file_path
  end

  def basename
    File.basename @file_path
  end

  def path
    File.absolute_path @file_path
  end
end