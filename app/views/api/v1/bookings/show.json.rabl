object false
child @booking, :root => "result" do
   attributes :id, :time, :estimated_cost, :state, :created_at, :updated_at
   child :user, object_root => false do
       :id, :full_name, :email_address
   end
   child :course, object_root => false do
       :id, :title, :description, :teaching_experience, :age_group
   end
end
node(:status) { @booking.nil? ? "22001" : "22000" }
node(:msg) {  @booking.nil? ? "booking not found" :"successful" }