object false
node(:status) { @course.nil? ? "22001" : "22000" }
node(:msg) { @course.nil? ? "course not found" :"successful" }