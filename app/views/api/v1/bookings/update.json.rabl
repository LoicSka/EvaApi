object false
node(:status) { |m| @booking.errors.empty? ? "22000" : "22001" }
node(:msg) { |m| @booking.errors.empty? ? "successful" : "#{@booking.errors.keys.first} #{@booking.errors.values.first.join}" }

child @booking, :if => @booking.errors.empty?, :root => "result" do
    attributes :id, :duration, :phone_number, :time, :days_of_week, :address, :estimated_cost, :state, :created_at, :updated_at
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