object false
node(:status) { @bookings.errors.empty? ? "22000" : "22001" }
node(:msg) { @bookings.errors.empty? ? "successful" : "#{@bookings.errors.keys.first} #{@bookings.errors.values.first.join(",")}" }

child @bookings, :if => @bookings.errors.empty?, :root => "result" do
    attributes :id, :time, :estimated_cost, :state, :created_at, :updated_at
    child :user, object_root => false do
        :id, :full_name, :email_address
    end
    child :course, object_root => false do
        :id, :title, :description, :teaching_experience, :age_group
    end
end
