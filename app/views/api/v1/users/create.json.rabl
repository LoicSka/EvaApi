object false
node(:status) { @user.errors.empty? ? "22000" : "22001" }
node(:msg) { @user.errors.empty? ? "successful" : "#{@user.errors.keys.first} #{@user.errors.values.first.join(",")}" }
node(:token) { @user.errors.empty? ? (Knock::AuthToken.new payload: { sub: @user.id }) : nil }

child @user, :if => @user.errors.empty?, :root => "result" do
    attributes :id, :first_name, :last_name, :email, :created_at, :updated_at
    node(:account) { |user| user.tutor_account.nil? ? nil : partial("api/v1/tutor_accounts/show", :object => false, locals: { tutor_account: user.tutor_account } ) }
end