# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'erb'

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end

task default: [:test]

namespace :binaries do
  def get_binaries(version)
    puts 'Updating python script'
    system("wget -O ./vendor/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/download/#{version}/yt-dlp")
    puts 'Updating Windows EXE'
    system("wget -O ./vendor/bin/yt-dlp.exe https://github.com/yt-dlp/yt-dlp/releases/download/#{version}/yt-dlp.exe")
  end

  desc 'Get binaries for specific version (run with `rake binaries:version[2015.07.07]`)'
  task :version, [:ver] do |_t, a|
    get_binaries(a[:ver])
  end
end

__END__
# Version file
