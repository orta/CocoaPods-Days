require "cocoapods"
require "cocoapods-core"

# returns an array from the diff log for the last x days
def specs_for_days_ago_diff days_ago
  sha = run_git_command_in_specs 'rev-list -n1 --before="' + days_ago + ' day ago" master'
  diff_log = run_git_command_in_specs "diff --name-status #{sha}"
  cleanup_git_logs diff_log
end

# returns an array from the diff log for the commit changes
def specs_for_git_diff start_commit, end_commit
  diff_log = run_git_command_in_specs "diff --name-status #{start_commit} #{end_commit}"
  cleanup_git_logs diff_log
end

# cleans up and removes modification notice to the diff
def cleanup_git_logs diff_log
  diff_log.lines.map do |line|

    line.slice!(0).strip!
    line.gsub! /\t/, ''
    line.gsub! /\n/, ''

  end
end

# We have to run commands from a different git root if we want to do anything in the Specs repo

def run_git_command_in_specs git_command
  Dir.chdir("Specs") do
   `git #{git_command}`
  end
end


unless Dir.exists? "Specs"
  `git clone https://github.com/CocoaPods/Specs.git`
else
  run_git_command_in_specs "pull origin master"
end

days = ARGV.shift
unless days
  puts 'Please specify the number of days on the command line'
  exit
end
specs = specs_for_days_ago_diff days

for spec_address in specs

  begin
    spec = Pod::Specification.from_file("Specs/" + spec_address)
    puts "Pod: #{spec.name} v#{spec.version} by #{spec.authors}"
    puts "   - #{spec.summary}"
    puts "   - #{spec.source}"
    puts ""

  rescue Exception => e
  end
end
