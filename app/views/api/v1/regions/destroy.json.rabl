object false
node(:status) { @region.nil? ? "22001" : "22000" }
node(:msg) { @region.nil? ? "region not found" :"successful" }