[![Gem Version](https://badge.fury.io/rb/duplicated_filename_checker.svg)](http://badge.fury.io/rb/duplicated_filename_checker)
[![Build Status](https://travis-ci.org/Shinya131/duplicated_filename_checker.svg?branch=master)](https://travis-ci.org/Shinya131/duplicated_filename_checker)
[![Coverage Status](https://coveralls.io/repos/Shinya131/duplicated_filename_checker/badge.svg?branch=master)](https://coveralls.io/r/Shinya131/duplicated_filename_checker?branch=master) 
[![Code Climate](https://codeclimate.com/github/Shinya131/duplicated_filename_checker/badges/gpa.svg)](https://codeclimate.com/github/Shinya131/duplicated_filename_checker)

# DuplicatedFilenameChecker

`duplicated_filename_checker` is duplicate file name checker in multiple directory with subdirectory.  
This tool is checking only filename, not checking file content.

## Installation

install:

    $ gem install duplicated_filename_checker

## Usage
### survey duplicate filename

```
$ dup-filename ./survey_dir1_root ./survey_dir2_root

## dupfilename1.png
1. /Users/shinya131/survey_dir1_root/dupfilename1.png
 * md5: 5b915134b95109c68e7515f4737c5e6d
 * mtime: 2015-03-03 15:14:35 +0900

2. /Users/shinya131/survey_dir2_root/subdirectory/dupfilename1.png
 * md5: 5b915134b95109c68e7515f4737c5e6d
 * mtime: 2015-03-03 15:14:35 +0900

## dupfilename2.png
1. /Users/shinya131/survey_dir1_root/dupfilename2.png
 * md5: 5f524466f49b96221fe7c5a6ddf5d881
 * mtime: 2014-10-16 20:19:07 +0900

2. /Users/shinya131/survey_dir2_root/dupfilename2.png
 * md5: 5ca13f9af7db4c8e80ac153fd4c0a552
 * mtime: 2015-03-03 15:14:35 +0900

```

### only filename option: `-l`
```
$ dup-filename -l ./survey_dir1_root ./survey_dir2_root
dupfilename1.png
dupfilename2.png

```

## Usage `duplicated_filename_checker` as library

You can use `duplicated_filename_checker` in ruby program.

#### install

Add this line to your application's Gemfile:
```ruby
gem 'duplicated_filename_checker'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install duplicated_filename_checker

#### example
```ruby
require 'duplicated_filename_checker'

servey_root_paths = ['./survey_dir1_root', './survey_dir2_root']
duplicate_file_profile_list = DuplicatedFilenameChecker::Check.new(*servey_root_paths).execute

p duplicate_file_profile_list
#=>
# {
#   "dupfilename1.png"=>
#   [
#     #<DuplicatedFilenameChecker::FileProfile:0x007f9aa4878188 @file_path=...>,
#     #<DuplicatedFilenameChecker::FileProfile:0x007f9aa48633a0 @file_path=...>
#   ],
#   "dupfilename2.png"=>
#   [
#     #<DuplicatedFilenameChecker::FileProfile:0x007f9aa4878160 @file_path=...>,
#     #<DuplicatedFilenameChecker::FileProfile:0x007f9aa4863210 @file_path=...>
#   ]
# }

duplicate_file_profiles = duplicate_file_profile_list['dupfilename1.png']
duplicate_file_profile = duplicate_file_profiles.first

p duplicate_file_profiles[0].path
#=> /Users/shinya131/survey_dir1_root/dupfilename1.png

p duplicate_file_profiles[1].path
#=> /Users/shinya131/survey_dir2_root/subdirectory/dupfilename1.png
```

## TODO
 * Performance tune.
 * Flexible ignore options.