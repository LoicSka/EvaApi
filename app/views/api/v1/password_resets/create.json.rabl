object false
node(:status) { @user.nil? ? "22001" : "22000" }
node(:msg) { @user.nil? ? "No such user, check credentials." : "successful"}

child @user, :if => !@user.nil?, :root => "result" do
    attributes :id, :email
end