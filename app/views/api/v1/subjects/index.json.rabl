object false
child @subjects, :root => "result", :object_root => false do
  attributes :id, :title :created_at, :updated_at
end
node(:status) { 22000 }
node(:msg) { "successful" }