object false
node(:status) { @booking.nil? ? "22001" : "22000" }
node(:msg) { @booking.nil? ? "booking not found" :"successful" }