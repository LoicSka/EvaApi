object false
child @bookings, :root => "result", :object_root => false do
  attributes :id, :time, :estimated_cost, :state, :created_at, :updated_at
  child :user, object_root => false do
      :id, :full_name, :email_address
  end
  child :course, object_root => false do
      :id, :title, :description, :teaching_experience, :age_group
  end
end
node(:status) { 22000 }
node(:msg) { "successful" }
