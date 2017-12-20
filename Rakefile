require 'rake'
require 'pathname'
require 'fileutils'

home = `printf $HOME`
timestamp = Time.now.strftime("%Y-%m-%d_%I-%M-%S")

task :install => %w(install:submodules install:files clean:symlinks)

namespace :install do
  desc "Update submodules"
  task :submodules do
    Dir.chdir(File.dirname(__FILE__)) { puts `git submodule sync && git submodule update --init` }
  end

  desc "install the dot files into user's home directory"
  task :files do

    replace_all = false
    Dir['*'].each do |file|
      next if %w[Rakefile README LICENSE bin ssh].include? file or %r{(.*)\.pub} =~ file

      dest = File.join(ENV['HOME'], ".#{file}")
      if File.exist?(dest) || File.symlink?(dest)
        if replace_all
          replace_file(file, timestamp)
        elsif Pathname.new(dest).realpath == Pathname.new(ENV['PWD']).join(file).realpath
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

    system %Q{mkdir -p "#{home}/bin"}

    Dir['bin/*'].each do |file|
      filepath = File.expand_path("#{home}/#{file}")
      if !(File.exist? filepath)
        puts "linking ~/#{file}"
        system %Q{ln -s "$PWD/#{file}" "#{home}/#{file}"}
      else
        puts "Existing ~/#{file} exists. Skipping..."
      end
    end

    # Link ssh config
    if !File.exist?("#{home}/.ssh/config")
      puts "linking ~/.ssh/config"
      system %Q{ln -s "$PWD/ssh/config" "#{home}/.ssh/config"}
    end
  end
end

namespace :clean do
  task :symlinks do
    Dir["#{ENV['HOME']}/{*,bin/*}"].each do |file|
      next unless File.symlink?(file)
      begin
        Pathname.new(file).realpath
      rescue Errno::ENOENT
        puts "Removing broken symlink at #{file}"
        File.delete(file)
      end
    end
  end
end

namespace :update do
  task :fzf do
    puts "Updating fzf..."
    system %Q{brew upgrade fzf}
    latest_fzf = Dir['/usr/local/Cellar/fzf/*'].sort_by { |v| Gem::Version.new(File.basename(v)) }.last
    system %Q{ln -sfh #{latest_fzf} $HOME/.fzf}
    system %Q{$HOME/.fzf/install --all}
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
