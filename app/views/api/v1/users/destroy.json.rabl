object false
node(:status) { @user.nil? ? "22001" : "22000" }
node(:msg) { @user.nil? ? "user not found" :"successful" }
node(:validations) { @user.errors.messages }