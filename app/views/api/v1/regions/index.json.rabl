object false
child @regions, :root => "result", :object_root => false do
  attributes :id, :country_name, :city_name, :location, :currency_symbol, :created_at, :updated_at
end
node(:status) { 22000 }
node(:msg) { "successful" }