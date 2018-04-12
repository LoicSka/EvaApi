object false
node(:status) { |m| @tag.errors.empty? ? "22000" : "22001" }
node(:msg) { |m| @tag.errors.empty? ? "successful" : "#{@tag.errors.keys.first} #{@tag.errors.values.first.join}" }

child @tag, :if => @tag.errors.empty?, :root => "result" do
     attributes :id, :title, :sub_title
end
