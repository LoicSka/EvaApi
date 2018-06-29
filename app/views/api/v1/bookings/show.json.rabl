object false
child @booking, :root => "result" do
    attributes :id, :time, :duration, :phone_number, :days_of_week, :address, :estimated_cost, :state, :created_at, :updated_at
    child :student, :object_root => false do
        attributes :id, :full_name, :gender, :age_group
        node(:user_full_name) do |student|
            student.user.nil? ? nil : student.user.full_name
        end
        node(:user_avatar_url) do |student|
            student.user.nil? ? nil : student.user.avatar_url
        end
    end
    child :tutor_account, :object_root => false do
        attributes :id, :wechat_id, :phone_number
        node(:full_name) do |tutor_account|
            tutor_account.user.nil? ? nil : tutor_account.user.full_name
        end
        node(:avatar_url) do |tutor_account|
            tutor_account.user.nil? ? nil : tutor_account.user.avatar_url
        end
    end
end
node(:status) { @booking.nil? ? "22001" : "22000" }
node(:msg) {  @booking.nil? ? "booking not found" :"successful" }