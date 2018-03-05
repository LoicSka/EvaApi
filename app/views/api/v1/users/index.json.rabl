object false
child @users, :root => "result", :object_root => false do
  attributes :id, :first_name, :last_name, :email, :created_at, :updated_at
  child :tutor_account, :object_root => false do
    attributes :id, :introduction, :gender, :dob, :phone_number, :weibo_url, :wechat_url, :occupation, :days_available, :state, :renewed_at, :expiring_at, :created_at, :updated_at
    node :region do |account|
        "#{account.region.city_name}, #{account.region.country_name}".titleize unless account.region.nil?
    end
  end
end
node(:status) { 22000 }
node(:msg) { "successful" }