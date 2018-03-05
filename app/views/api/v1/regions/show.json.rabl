object false
child @region, :root => "result" do
   attributes :id, :country_name, :city_name, :location, :currency_symbol, :created_at, :updated_at
end
node(:status) { @region.nil? ? "22001" : "22000" }
node(:msg) { @region.nil? ? "region not found" :"successful" }