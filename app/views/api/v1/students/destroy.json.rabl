object false
node(:status) { @student.nil? ? "22001" : "22000" }
node(:msg) { @student.nil? ? "student not found" :"successful" }