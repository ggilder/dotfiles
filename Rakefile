require 'rake'
require 'pathname'
require 'ftools' if RUBY_VERSION < "1.9"

hostname =  `printf ${HOSTNAME%%.*}`
home = `printf $HOME`
timestamp = Time.now.strftime("%Y-%m-%d_%I-%M-%S")

task :install => 'install:files'

namespace :install do

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

  desc "Create symbolic link for kaleidoscope integration with git difftool"
  task :ksdiff do
    ksdiff = File.expand_path("/usr/local/bin/ksdiff-wrapper")
    opendiff = File.expand_path("/usr/bin/opendiff")
    if File.exist?(ksdiff)
      if !File.exist?(opendiff) && !File.symlink?(opendiff)
        puts "#{opendiff} doesn't exist, linking..."
        system %Q{sudo ln -s #{ksdiff} #{opendiff}}
      elsif File.exist?(opendiff) && !File.symlink?(opendiff)
        # file already exists. back it up
        puts "moving #{opendiff} to #{opendiff}_orig"
        system %Q{sudo mv #{opendiff} #{opendiff}_orig}
        puts "linking #{ksdiff} to #{opendiff}"
        system %Q{sudo ln -s #{ksdiff} #{opendiff}}
      else File.exist?(opendiff) && File.symlink?(opendiff)
        puts "file already linked"
      end
    else
      puts "please install ksdiff before runnning this tool"
    end
  end

  desc "Set up command-T plugin for vim"
  task :commandt do
    path = File.join(File.dirname(__FILE__), "vim/bundle/command-t/ruby/command-t")
    puts `cd #{path} && ruby extconf.rb && make`
  end
end

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
