object false
node(:status) { |m| @student.errors.empty? ? "22000" : "22001" }
node(:msg) { |m| @student.errors.empty? ? "successful" : "#{@student.errors.keys.first} #{@student.errors.values.first.join}" }

child @student, :if => @course.errors.empty?, :root => "result" do
     attributes :id, :full_name, :gender, :days_available
     child :criteria, :object_root => false do
         attributes :id, :type, values
     end
end