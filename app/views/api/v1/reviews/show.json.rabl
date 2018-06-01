object false
child @review, :root => "result" do
    attributes :id, :content, :created_at, :updated_at
    node :user do |review|
        review.user.full_name
    end
    node :tutor do |review|
        review.rating.tutor_account.user.full_name
    end
    node :rating do |review|
        review.rating.value
    end
end
node(:status) { @review.nil? ? "22001" : "22000" }
node(:msg) {  @review.nil? ? "review not found" :"successful" }