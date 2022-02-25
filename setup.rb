def load_dependencies(path)
  file = open(path)
  file_content = file.read()
  lines = file_content.split("\n")
  return lines
end

load_dependencies("ruby/gems.txt")

