object false
child @users, :root => "result", :object_root => false do
  attributes :id, :first_name, :last_name, :email_address, :created_at, :updated_at
end
node(:status) { 22000 }
node(:msg) { "successful" }