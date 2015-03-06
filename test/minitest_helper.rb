$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'duplicated_filename_checker'

require 'minitest/autorun'

def test_fullpath
  File.dirname(__FILE__)
end