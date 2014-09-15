require 'rake'
require 'pathname'
require 'fileutils'

home = `printf $HOME`
timestamp = Time.now.strftime("%Y-%m-%d_%I-%M-%S")

task :install => %w(install:submodules install:files)

namespace :install do
  desc "Update submodules"
  task :submodules do
    Dir.chdir(File.dirname(__FILE__)) { puts `git submodule sync && git submodule update --init` }
  end

  desc "install the dot files into user's home directory"
  task :files do

    replace_all = false
    Dir['*'].each do |file|
      next if %w[Rakefile README LICENSE bin].include? file or %r{(.*)\.pub} =~ file

      dest = File.join(ENV['HOME'], ".#{file}")
      if File.exist?(dest) || File.symlink?(dest)
        if replace_all
          replace_file(file, timestamp)
        elsif Pathname.new(dest).realpath.to_s == File.join(ENV['PWD'], file)
          puts "correct symlink already exists for "+File.join(ENV['PWD'], file)
        else
          print "overwrite ~/.#{file}? [ynaq] "
          case $stdin.gets.chomp
          when 'a'
            replace_all = true
            replace_file(file, timestamp)
          when 'y'
            replace_file(file, timestamp)
          when 'q'
            exit
          else
            puts "skipping ~/.#{file}"
          end
        end
      else
        link_file(file)
      end
    end

    # link files in bin dir
    # disabling backup because existing files are not overwritten anyway
    #if `command ls -1 "#{home}/bin" 2>/dev/null` != ''
    #  # make backup if bin dir is not empty
    #  system %Q{mkdir -p "$HOME/_dot_backups/#{timestamp}/bin/"}
    #end
    system %Q{mkdir -p "#{home}/bin"}

    Dir['bin/*'].each do |file|
      filepath = File.expand_path("#{home}/#{file}")
      if !(File.exist? filepath)
        puts "linking ~/#{file}"
        system %Q{ln -s "$PWD/#{file}" "#{home}/#{file}"}
      else
        puts "Existing ~/#{file} exists. Skipping..."
        # could back up here
        # system %Q{cp -RLi "#{home}/#{file}" "#{home}/_dot_backups/#{timestamp}/#{file}"}
        # system %Q{rm "#{home}/#{file}"}
      end
    end
  end
end

task :default => :install

def replace_file(file, timestamp)
  system %Q{mkdir -p "$HOME/_dot_backups/#{timestamp}"}
  if File.exist?(File.join(ENV['HOME'], ".#{file}"))
    puts "Backing up $HOME/.#{file} to $HOME/_dot_backups/#{timestamp}/#{file}"
    system %Q{cp -RLi "$HOME/.#{file}" "$HOME/_dot_backups/#{timestamp}/#{file}"}
    system %Q{rm "$HOME/.#{file}"}
  end
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
