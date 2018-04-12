object false
child @course, :root => "result" do
   attributes :id, :title, :expertise, :teaching_experience, :age_group, :description, :hourly_rate, :created_at, :updated_at
   child :subject, :object_root => false do
      attributes :id, :title
   end
   child :tags, :object_root => false do
      attributes :id, :title, :sub_title
   end
end
node(:status) { @course.nil? ? "22001" : "22000" }
node(:msg) {  @course.nil? ? "course not found" :"successful" }