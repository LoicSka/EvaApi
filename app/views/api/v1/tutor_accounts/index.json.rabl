object false
child @tutor_accounts, :root => "result", :object_root => false do
 attributes :id, :introduction, :gender, :dob, :phone_number, :district, :weibo_url, :wechat_url, :occupation, :days_available, :teaching_experience, :state, :renewed_at, :expiring_at, :created_at, :updated_at
 child :region, :object_root => false do
     attributes :id, :country_name, :city_name, :location, :currency_symbol
 end
 node(:full_name) do |account|
    account.user.full_name
 end
 node(:avatar_url) do |account|
    account.user.avatar_url
 end
 node(:pro) do |account|
    account.occupation == 'Full-time tutor'
 end
 node(:location) do |account|
    "#{account.region.city_name}#{account.district.nil? ? nil : ', ' + account.district}" unless account.region.nil?
 end
 child :courses, :object_root => false do
    attributes :id, :title, :description, :teaching_experience, :age_group, :email
 end
 child :bookings, :object_root => false do
     attributes :id, :time, :estimated_cost, :state, :created_at, :updated_at
  end
end
node(:status) { 22000 }
node(:msg) { "successful" }
