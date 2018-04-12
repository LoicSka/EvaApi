object false
node(:status) { |m| @user.errors.empty? ? "22000" : "22001" }
node(:msg) { |m| @user.errors.empty? ? "successful" : "#{@user.errors.keys.first} #{@user.errors.values.first.join}" }
node(:result) { @user.errors.empty? ? (Knock::AuthToken.new payload: @user.attributes.reject {|k,v| ['password_hash', 'avatar'].include?(k)}.merge({full_name: @user.full_name, avatar_url: @user.avatar_url, is_tutor: @user.tutor_account.present?, tutor_account_id: @user.tutor_account.present? ? @user.tutor_account.id : nil, region_id: @user.tutor_account.present? ? @user.tutor_account.region.id : nil, region_name: @user.tutor_account.present? ? "#{@user.tutor_account.region.city_name}, #{@user.tutor_account.region.country_name}" : nil }.merge( @user.tutor_account.present? ? @user.tutor_account.attributes.reject {|k,v| ["_id", "user_id"].include?(k)} : {}))) : nil }
node(:validations) { @user.errors.messages }
