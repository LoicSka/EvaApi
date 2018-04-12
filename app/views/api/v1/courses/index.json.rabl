object false
child @courses, :root => "result", :object_root => false do
  attributes :id, :title, :expertise, :teaching_experience, :age_group, :description, :hourly_rate, :created_at, :updated_at
  node(:accepted_bookings) { |c| c.accepted_bookings.count }
  child :subject, :object_root => false do
    attributes :id, :title
  end
  child :tags, :object_root => false do
    attributes :id, :title, :sub_title
  end
end
node(:status) { 22000 }
node(:msg) { "successful" }
