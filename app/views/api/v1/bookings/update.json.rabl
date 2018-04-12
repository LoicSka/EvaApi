object false
node(:status) { |m| @booking.errors.empty? ? "22000" : "22001" }
node(:msg) { |m| @booking.errors.empty? ? "successful" : "#{@booking.errors.keys.first} #{@booking.errors.values.first.join}" }

child @booking, :if => @booking.errors.empty?, :root => "result" do
    attributes :id, :time, :estimated_cost, :state, :created_at, :updated_at
    child :user, object_root => false do
        :id, :full_name, :email_address
    end
    child :course, object_root => false do
        :id, :title, :description, :teaching_experience, :age_group
    end
end