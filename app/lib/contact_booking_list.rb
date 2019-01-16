require_relative('achiever')

class ContactBookingList
  def self.fromAchiever(contactNo)
    bookings = Array.new
    achiever = Achiever.new
    results = achiever.fetchContactBookingsListings(contactNo)
    puts '***************** results ****************'
    puts results

    results.each do |result|
      bookings << ContactBooking.new(result)
    end
    bookings
  end
end
