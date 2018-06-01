object false
node(:status) { @review.errors.empty? ? "22000" : "22001" }
node(:msg) { @review.errors.empty? ? "successful" : "#{@review.errors.keys.first} #{@review.errors.values.first.join(",")}" }

child @review, :if => @review.errors.empty?, :root => "result" do
    attributes :id, :content, :created_at, :updated_at
    node :user do |review|
        review.rating.user.full_name
    end
    node :tutor do |review|
        review.rating.tutor_account.user.full_name
    end
    node :rating do |review|
        review.rating.value
    end
end
