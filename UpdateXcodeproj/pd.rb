
# pwd
# ls
require 'xcodeproj'
project_path = 'Elearning.xcodeproj'
project = Xcodeproj::Project.open(project_path)

puts project.path

file = project.files.each do |file|
	break file if file.name == "weexelearn"
end


puts file.path
puts file.isa
file.set_path("../../weexelearn")
puts file.path
puts file.isa

project.save()



