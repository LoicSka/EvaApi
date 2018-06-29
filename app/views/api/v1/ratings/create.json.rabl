object false
node(:status) { @rating.errors.empty? ? "22000" : "22001" }
node(:msg) { @rating.errors.empty? ? "successful" : "#{@rating.errors.keys.first} #{@rating.errors.values.first.join(",")}" }

child @rating, :if => @rating.errors.empty?, :root => "result" do
    attributes :id, :value, :created_at, :updated_at
    node :user do |rating|
        rating.user.full_name
    end
    child :tutor_account, :object_root => false do
      attributes :id, :rating
    end
    child :review, :object_root => false do
        attributes :id, :content, :created_at, :updated_at
        node :user do
            @rating.user.full_name
        end
        node :tutor do
            @rating.tutor_account.user.full_name
        end
        node :rating do
            @rating.value
        end
    end
end
