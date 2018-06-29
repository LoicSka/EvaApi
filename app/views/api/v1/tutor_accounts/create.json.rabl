object false
node(:status) { @tutor_account.errors.empty? ? "22000" : "22001" }
node(:msg) { @tutor_account.errors.empty? ? "successful" : "#{@tutor_account.errors.keys.first} #{@tutor_account.errors.values.first.join(",")}" }

child @tutor_account, :if => @tutor_account.errors.empty?, :root => "result" do
    attributes :id, :introduction, :gender, :phone_number, :occupation, :district, :weibo_url, :wechat_id, :certifications, :occupation, :days_available, :teaching_experience, :state, :renewed_at, :levels, :hourly_rate, :expiring_at, :country_of_origin, :created_at, :updated_at
    child :region, :object_root => false do
         attributes :id, :country_name, :city_name, :location, :currency_symbol
    end
    child :user, :object_root => false do
        attributes :id, :full_name, :email
    end
    child :courses, :object_root => false do
        attributes :id, :title, :description, :teaching_experience, :age_group, :email
    end
end
