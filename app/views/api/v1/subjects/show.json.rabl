object false
child @subject, :root => "result" do
   attributes :id, :title
end
node(:status) { @subject.nil? ? "22001" : "22000" }
node(:msg) {  @subject.nil? ? "subject not found" :"successful" }