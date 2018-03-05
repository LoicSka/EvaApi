object false
node(:status) { |m| @region.errors.empty? ? "22000" : "22001" }
node(:msg) { |m| @region.errors.empty? ? "successful" : "#{@region.errors.keys.first} #{@region.errors.values.first.join}" }

child @region, :if => @region.errors.empty?, :root => "result" do
     attributes :id, :country_name, :city_name, :location, :currency_symbol, :created_at, :updated_at
end