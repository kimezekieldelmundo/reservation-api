require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  test "start date should be on or before end_data" do
    reservation = Reservation.new(start_date: Date.strptime("2021-03-16", '%Y-%m-%d'), end_date: Date.strptime("2021-03-12", '%Y-%m-%d'))
    assert_not reservation.save
  end

  test "guests should be total of adult,children,infant" do
    reservation = Reservation.new(guests: 4, adults: 2, children: 1, infants: 0)
    assert_not reservation.save
  end
end
