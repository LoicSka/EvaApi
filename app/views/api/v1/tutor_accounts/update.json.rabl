object false
node(:status) { |m| @tutor_account.errors.empty? ? "22000" : "22001" }
node(:msg) { |m| @tutor_account.errors.empty? ? "successful" : "#{@tutor_account.errors.keys.first} #{@tutor_account.errors.values.first.join}" }

child @tutor_account, :if => @tutor_account.errors.empty?, :root => "result" do
  attributes :id, :introduction, :gender, :dob, :phone_number, :weibo_url, :wechat_url, :occupation, :days_available, :state, :renewed_at, :expiring_at, :created_at, :updated_at
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