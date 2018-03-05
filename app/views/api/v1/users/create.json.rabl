object false
node(:status) { @user.errors.empty? ? "22000" : "22001" }
node(:msg) { @user.errors.empty? ? "successful" : "#{@user.errors.keys.first} #{@user.errors.values.first.join(",")}" }
node(:token) { @user.errors.empty? ? (Knock::AuthToken.new payload: { sub: @user.id }) : nil }

child @user, :if => @user.errors.empty?, :root => "result" do
    attributes :id, :uid, :im_uid, :im_password, :username, :first_name, :last_name, :email_address, :created_at, :updated_at
end
