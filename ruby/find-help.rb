require 'optparse'
require 'open3'

MAN_COMMAND = 'man'
UNIX_SHORT_HELP_FLAG = '-h'
UNIX_LONG_HELP_FLAG = '--help'
GO_LONG_HELP_FLAG = '-help'

COMMAND_NOT_FOUND_EXP = Regexp.new "zsh: command not found:"
MAN_PAGE_NOT_FOUND_EXP = Regexp.new "No manual entry for"

outlimit = 0
color = true

options = {}

OptionParser.new do |parser|
  parser.banner = "Utility to search for help in available docu places"
  parser.program_name = "FindHelp"

  parser.on("-e", "--exp REGEXP", Regexp, "Search for this REGEXP") do |exp|
    options[:exp] = exp
  end

  parser.on("-n", "--name STRING", String, "Name for which to search for") do |name|
    options[:name] = name
  end
  
  parser.on("-l", "--limit INT", Integer, "Limit of printed output") do |limit|
    outlimit = limit
  end

  parser.on("-d", "--no-color", "Disable colorfull output") do
    color = false
  end

  parser.on("-h", "--help", "Prints this help") do 
    puts parser
    exit 
  end

end.parse!

def run_command(command_name)
  output = ""
  begin
    Open3.popen2e(command_name) {|i, o, t|
      output = o.read
    }
  rescue Errno::ENOENT
    output = "No manual entry for"
  end
  output
end

def analyze_output(output, match_expression)
  ret = []
  if MAN_PAGE_NOT_FOUND_EXP.match?(output) or COMMAND_NOT_FOUND_EXP.match?(output)
    return ret
  end
  lines = output.split /\n/
  lines.each do |line|
    if match_expression.match? line
      ret << line
    end
  end
end

def print_match(match, limit)
  print_matches = match.take limit
  print_matches.each do |print_match|
    puts print_match
  end
end

def generate_variants(command_name)
  ret = []
  ret << "#{MAN_COMMAND} #{command_name}"
  ret << "#{command_name} #{UNIX_SHORT_HELP_FLAG}"
  ret << "#{command_name} #{UNIX_LONG_HELP_FLAG}"
  ret << "#{command_name} #{GO_LONG_HELP_FLAG}"
  ret
end

match_expression = Regexp.new ""
command_name = ""

unless options[:exp] == nil
  match_expression = options[:exp]
else
  puts "It's necessary to pass an expression"
  exit 1
end

unless options[:name] == nil
  command_name = options[:name]
else
  puts "It's necessary to pass a search name"
  exit 1
end

variants = generate_variants(command_name)
variant_with_match = []

variants.each do |variant|
  output = run_command(variant)
  match = analyze_output(output, match_expression)
  variant_with_match << [variant, match]
end

variant_with_match.each do |(variant, match)|
  if color
    color_length = match.length > 0 ? "\e[32m#{match.length}\e[0m" : "\e[31m#{match.length}\e[0m"
    puts "Found \e[1m#{color_length}\e[22m results in output of command `#{variant}`"
  else
    puts "Found #{match.length} results in output of command #{variant}"
  end
end

if outlimit == 0
  exit
end

already_printed_matches = []
already_printed_variants = []

variant_with_match.each do |(variant, matches)|
  unless matches.length == 0
    joined_matches = matches.join
    output_of_string = " Output of #{variant}:"
    if color
      puts "\e[31m#{output_of_string}\e[0m"
    else 
      puts output_of_string
    end
    unless already_printed_matches.include? joined_matches
      puts "\n"
      print_match(matches, outlimit)
      already_printed_matches << joined_matches
      already_printed_variants << variant
    else
      variant_index = already_printed_matches.index joined_matches
      already_variant = already_printed_variants[variant_index]

      already_string = "Ouput was already printed with #{already_variant}"

      if color 
        puts "\e[37m#{already_string}\e[0m"
      else
        puts already_string
      end
    end
    puts "\n"
  end
end
