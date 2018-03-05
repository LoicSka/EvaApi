object false
child @course, :root => "result" do
   attributes :id, :title, :teaching_experience, :age_group, :created_at, :updated_at
   node :subject do |course|
     course.subject.title
   end
end
node(:status) { @course.nil? ? "22001" : "22000" }
node(:msg) {  @course.nil? ? "course not found" :"successful" }