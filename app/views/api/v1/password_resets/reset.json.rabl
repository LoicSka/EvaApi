object false
node(:status) { @user.nil? ? "22002" : (@user.errors.empty? ? "22000" : "22001") }
node(:msg) { @user.nil? ? "No such user, check credentials." : (@user.errors.empty? ? "successful" : "#{@user.errors.keys.first} #{@user.errors.values.first.join(",")}")}

child @user, :if => (!@user.nil? && @user.errors.empty?), :root => "result" do
    attributes :id, :email
end