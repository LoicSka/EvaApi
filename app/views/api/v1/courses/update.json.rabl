object false
node(:status) { |m| @course.errors.empty? ? "22000" : "22001" }
node(:msg) { |m| @course.errors.empty? ? "successful" : "#{@course.errors.keys.first} #{@course.errors.values.first.join}" }

child @course, :if => @course.errors.empty?, :root => "result" do
     attributes :id, :title, :expertise, :teaching_experience, :age_group, :description, :hourly_rate, :created_at, :updated_at
     child :subject, :object_root => false do
        attributes :id, :title
     end
     child :tags, :object_root => false do
        attributes :id, :title, :sub_title
     end
end