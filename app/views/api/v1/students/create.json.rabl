object false
node(:status) { @student.errors.empty? ? "22000" : "22001" }
node(:msg) { @student.errors.empty? ? "successful" : "#{@student.errors.keys.first} #{@student.errors.values.first.join(",")}" }
child @student, :if => @student.errors.empty?, :root => "result" do
    attributes :id, :full_name, :user_id, :gender, :days_available
    child :criteria, :object_root => false do
        attributes :id, :type, :values
    end
end