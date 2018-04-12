object false
node(:status) { @user.errors.empty? ? "22000" : "22001" }
node(:msg) { @user.errors.empty? ? "successful" : "#{@user.errors.keys.first} #{@user.errors.values.first.join(",")}" }
node(:result) { @user.errors.empty? ? (Knock::AuthToken.new payload: @user.attributes.reject {|k,v| ['password_hash', 'avatar'].include?(k)}.merge({full_name: @user.full_name, avatar_url: @user.avatar_url, is_tutor: @user.tutor_account.present?, tutor_account_id: @user.tutor_account.id})) : nil }
node(:validations) { @user.errors.messages }