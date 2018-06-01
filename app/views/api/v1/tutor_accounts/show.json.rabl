object false
child @tutor_account, :root => "result" do
    attributes :id, :introduction, :gender, :phone_number, :occupation, :district, :weibo_url, :wechat_id, :certifications, :occupation, :days_available, :teaching_experience, :state, :renewed_at, :levels, :expiring_at, :country_of_origin, :created_at, :updated_at
    child :region, :object_root => false do
        attributes :id, :country_name, :city_name, :location, :currency_symbol
    end
    node(:full_name) do |account|
       account.user.full_name
    end
    node(:avatar_url) do |account|
       account.user.avatar_url
    end
    node(:rating) do |account|
       account.rating
    end
    node(:is_pro) do |account|
       account.occupation == 'Full-time tutor'
    end
    node(:subject_titles) do |account|
        account.subject_titles
    end
    node(:location) do |account|
       "#{account.region.city_name}#{account.district.nil? ? nil : ', ' + account.district}" unless account.region.nil?
    end
    child :bookings, :object_root => false do
       attributes :id, :time, :estimated_cost, :state, :created_at, :updated_at
    end
end
node(:status) { @tutor_account.nil? ? "22001" : "22000" }
node(:msg) {  @tutor_account.nil? ? "tutor_account not found" :"successful" }