object false
child @tutor_accounts, :root => "result", :object_root => false do
  attributes :id, :introduction, :gender, :dob, :phone_number, :weibo_url, :wechat_url, :occupation, :days_available, :state, :renewed_at, :expiring_at, :membership, :created_at, :updated_at
end
node(:status) { 22000 }
node(:msg) { "successful" }