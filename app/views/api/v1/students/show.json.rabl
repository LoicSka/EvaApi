object false
child @student, :root => "result" do
    attributes :id, :full_name, :gender, :days_available
    child :criteria, :object_root => false do
        attributes :id, :type, values
    end
end
node(:status) { @student.nil? ? "22001" : "22000" }
node(:msg) {  @student.nil? ? "student not found" :"successful" }