object false
node(:status) { @subject.errors.empty? ? "22000" : "22001" }
node(:msg) { @subject.errors.empty? ? "successful" : "#{@subject.errors.keys.first} #{@subject.errors.values.first.join(",")}" }

child @subject, :if => @subject.errors.empty?, :root => "result" do
    attributes :id, :title, :created_at, :updated_at
end
