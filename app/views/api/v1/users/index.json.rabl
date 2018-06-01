object false
child @users, :root => "result", :object_root => false do
  attributes :id, :first_name, :last_name, :email, :verified, :avatar_url, :created_at, :updated_at
  child :tutor_account, :object_root => false do
    attributes :id, :introduction, :gender, :dob, :district, :phone_number, :weibo_url, :wechat_id, :country_of_origin, :occupation, :certifications, :teaching_experience, :days_available, , :state, :renewed_at, :expiring_at, :created_at, :updated_at
    node :region do |account|
        "#{account.region.city_name}, #{account.region.country_name}".titleize unless account.region.nil?
    end
  end
end
node(:status) { 22000 }
node(:msg) { "successful" }