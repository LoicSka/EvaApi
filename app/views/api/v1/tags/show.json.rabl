object false
child @tag, :root => "result" do
   attributes :id, :title, :sub_title
end
node(:status) { @tag.nil? ? "22001" : "22000" }
node(:msg) { @tag.nil? ? "tag not found" :"successful" }