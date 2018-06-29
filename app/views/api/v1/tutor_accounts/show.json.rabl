object false
child @tutor_account, :root => "result" do
    attributes :id, :introduction, :gender, :phone_number, :occupation, :district, :weibo_url, :wechat_id, :certifications, :occupation, :days_available, :teaching_experience, :state, :renewed_at, :levels, :last_seen, :expiring_at, :country_of_origin, :created_at, :updated_at, :hourly_rate
    child :region, :object_root => false do
        attributes :id, :country_name, :city_name, :location, :currency_symbol
    end
    node(:full_name) do |account|
       account.user.full_name
    end
    node(:avatar_url) do |account|
       account.user.avatar_url
    end
    node(:rating) do |account|
       account.rating
    end
    node(:is_pro) do |account|
       account.occupation == 'Full-time tutor'
    end
    node(:subject_titles) do |account|
        account.subject_titles
    end
    node(:student_count) do |account|
        account.student_count
    end
    node(:confirmed_booking_count) do |account|
        account.bookings.confirmed.count
    end
    node(:booking_count) do |account|
        account.bookings.count
    end
    node(:location) do |account|
        [account.region.city_name, account.district.nil? ? nil : account.district] unless account.region.nil?
    end
    node(:review_count) do |account|
        account.review_count
    end
    node(:unseen_review_count) do |account|
        account.last_seen[:reviews].nil? ? 0 : account.review_count - account.last_seen[:reviews]
    end
    node(:unseen_booking_count) do |account|
        account.last_seen[:bookings].nil? ? 0 : account.booking_count - account.last_seen[:bookings]
    end
    node(:booked_days) do |account|
        account.booked_days
    end
    child :bookings, :object_root => false do
        attributes :id, :time, :duration, :phone_number, :days_of_week, :estimated_cost, :state, :created_at, :updated_at
        child :student, :object_root => false do
            attributes :id, :full_name, :gender, :age_group
            node(:user_full_name) do |student|
                student.user.nil? ? nil : student.user.full_name
            end
            node(:user_avatar_url) do |student|
                student.user.nil? ? nil : student.user.avatar_url
            end
        end
    end
    child :matches, :object_root => false do
        attributes :id, :score, :created_at
        child :student, :object_root => false do
            attributes :id, :full_name, :gender
            # node(:user_full_name) do |student|
            #     student.user.nil? ? nil : student.user.full_name
            # end
            # node(:user_avatar_url) do |student|
            #     student.user.nil? ? nil : student.user.avatar_url
            # end
        end
    end
end
node(:status) { @tutor_account.nil? ? "22001" : "22000" }
node(:msg) {  @tutor_account.nil? ? "tutor_account not found" :"successful" }