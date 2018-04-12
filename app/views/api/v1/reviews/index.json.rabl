object false
child @reviews, :root => "result", :object_root => false do
  attributes :id, :content, :created_at, :updated_at
  node :user do |review|
      review.user.full_name
  end
  node :tutor do |review|
      review.tutor_account.user.full_name
  end
end
node(:status) { 22000 }
node(:msg) { "successful" }
