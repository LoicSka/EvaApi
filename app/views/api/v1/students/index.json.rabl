object false
child @students, :root => "result", :object_root => false do
  attributes :id, :full_name, :gender, :days_available
  child :criteria, :object_root => false do
    attributes :id, :type, values
  end
end
node(:status) { 22000 }
node(:msg) { "successful" }