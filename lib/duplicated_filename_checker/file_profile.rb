require 'digest/md5'

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

  def md5_digest
    Digest::MD5.file(path).to_s
  end
end