object false
node(:status) { @user.errors.empty? ? "22000" : "22001" }
node(:msg) { @user.errors.empty? ? "successful" : "#{@user.errors.keys.first} #{@user.errors.values.first.join(",")}" }
child @user, :root => "result" do
    attributes :id, :first_name, :last_name, :email
end
node(:validations) { @user.errors.messages }
