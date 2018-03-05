object false
node(:status) { @course.errors.empty? ? "22000" : "22001" }
node(:msg) { @course.errors.empty? ? "successful" : "#{@course.errors.keys.first} #{@course.errors.values.first.join(",")}" }

child @course, :if => @course.errors.empty?, :root => "result" do
    attributes :id, :title, :teaching_experience, :age_group, :created_at, :updated_at
    node :subject do |course|
        course.subject.title
    end
end
