object false
node(:status) { |m| @user.errors.empty? ? "22000" : "22001" }
node(:msg) { |m| @user.errors.empty? ? "successful" : "#{@user.errors.keys.first} #{@user.errors.values.first.join}" }

child @user, :if => @user.errors.empty?, :root => "result" do
    attributes :id, :first_name, :last_name, :email, :created_at, :updated_at
    child :tutor_account, :object_root => false do
       attributes :id, :introduction, :gender, :dob, :phone_number, :weibo_url, :wechat_url, :occupation, :days_available, :state, :renewed_at, :expiring_at, :created_at, :updated_at
       node :region do |account|
           "#{account.region.city_name}, #{account.region.country_name}".titleize unless account.region.nil?
       end
   end
end

