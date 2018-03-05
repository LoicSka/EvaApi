object false
child @tutor_accounts, :root => "result", :object_root => false do
 attributes :id, :introduction, :gender, :dob, :phone_number, :weibo_url, :wechat_url, :occupation, :days_available, :state, :renewed_at, :expiring_at, :created_at, :updated_at
 node :region do |account|
    "#{ account.region.city_name }, #{ account.region.country_name }".titleize unless account.region.nil?
 end
 child :user, :object_root => false do
    attributes :id, :full_name, :email
 end
 child :courses, :object_root => false do
    attributes :id, :title, :description, :teaching_experience, :age_group, :email
 end
end
node(:status) { 22000 }
node(:msg) { "successful" }
