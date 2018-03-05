object false
child @courses, :root => "result", :object_root => false do
  attributes :id, :title, :teaching_experience, :age_group, :created_at, :updated_at
  node :subject do |course|
    course.subject.title
  end
end
node(:status) { 22000 }
node(:msg) { "successful" }
