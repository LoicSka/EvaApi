object false
child @reviews, :root => "result", :object_root => false do
  attributes :id, :content, :created_at, :updated_at
  node :user do |review|
      review.rating.user.full_name
  end
  node :tutor do |review|
      review.rating.tutor_account.user.full_name
  end
  node :rating do |review|
      review.rating.value
  end
end
node(:status) { 22000 }
node(:msg) { "successful" }
