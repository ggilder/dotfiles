require 'rake'
require 'pathname'
require 'fileutils'

home = `printf $HOME`
timestamp = Time.now.strftime("%Y-%m-%d_%I-%M-%S")

task :install => %w(install:dependencies install:submodules clean:symlinks install:files update:fzf install:vimplugs install:agent_config)

namespace :install do
  desc "Install dependencies"
  task :dependencies do
    ensure_homebrew_installed
    brew_bundle || exit(1)
    run_app("/Applications/Clipy.app")
    run_app("/Applications/UTCMenuClock.app")
    run_app("/Applications/Sleep Control Center.app")
    run_app("/Applications/Hidden Bar.app")
  end

  desc "Update submodules"
  task :submodules do
    Dir.chdir(File.dirname(__FILE__)) { puts `git submodule sync && git submodule update --init` }
  end

  desc "install the dot files into user's home directory"
  task :files do

    replace_all = false
    dot_dir = Pathname.new(File.expand_path("./dot"))
    Dir["#{dot_dir}/*"].each do |file|
      dest_name = Pathname.new(file).relative_path_from(dot_dir)
      dest = File.join(ENV['HOME'], ".#{dest_name}")
      if File.exist?(dest) || File.symlink?(dest)
        if replace_all
          replace_symlink(file, dest, timestamp)
        elsif (Pathname.new(dest).realpath rescue nil) == Pathname.new(file).realpath
          puts "correct symlink already exists for #{dest}"
        else
          print "overwrite ~/.#{dest_name}? [ynaq] "
          case $stdin.gets.chomp
          when 'a'
            replace_all = true
            replace_symlink(file, dest, timestamp)
          when 'y'
            replace_symlink(file, dest, timestamp)
          when 'q'
            exit
          else
            puts "skipping ~/.#{file}"
          end
        end
      else
        link_file(file, dest)
      end
    end

    system %Q{mkdir -p "#{home}/bin"}

    Dir['bin/*'].each do |file|
      filepath = File.expand_path("#{home}/#{file}")
      if !(File.exist?(filepath) || File.symlink?(filepath))
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

  desc "Install vim plugins"
  task :vimplugs do
    puts "Updating vim plugins..."
    system %Q{nvim --headless +PlugUpdate +PlugInstall +qall}
  end

  desc "Install coding agent config"
  task :agent_config do
    source = File.expand_path("agents/AGENTS.md")
    target = Pathname.new("~").expand_path.join(".claude", "CLAUDE.md")
    if !target.exist?
      link_file(source, target.to_s)
    else
      print "overwrite #{target.to_s}? [ynq] "
      case $stdin.gets.chomp
      when 'y'
        replace_symlink(source, target.to_s, timestamp)
      when 'q'
        exit
      else
        puts "skipping ~/.#{file}"
      end
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
    latest_fzf = Dir['{/usr/local,/opt/homebrew}/Cellar/fzf/*'].sort_by { |v| Gem::Version.new(File.basename(v)) }.last
    system %Q{ln -sfh #{latest_fzf} $HOME/.fzf}
    system %Q{$HOME/.fzf/install --all}
  end
end

task :default => :install

def replace_symlink(source, dest, timestamp)
  raise "Unsafe destination!" unless dest.start_with?("#{ENV['HOME']}/.")
  system %Q{mkdir -p "$HOME/_dot_backups/#{timestamp}"}
  if File.exist?(dest) || File.symlink?(dest)
    puts "Backing up #{dest} to $HOME/_dot_backups/#{timestamp}/"
    system %Q{cp -a "#{dest}" "$HOME/_dot_backups/#{timestamp}/"}
    system %Q{rm -rf "#{dest}"}
  end
  link_file(source, dest)
end

def link_file(file, dest)
  puts "linking #{dest} -> #{file}"
  system %Q{ln -s "#{file}" "#{dest}"}
end

def ensure_homebrew_installed
  if !system("which brew")
    system(%{/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"})
    ENV["PATH"] = "/opt/homebrew/bin/:#{ENV["PATH"]}"
  end
end

def brew_bundle
  system("brew bundle")
end

def run_app(app)
  if !system("ps aux | grep '#{app}' | grep -v grep")
    system("open", app)
  end
end
