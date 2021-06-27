require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
    test "email_uniqueness" do
        guest1 = Guest.create(email: "admin@gmail.com")
        guest2 = Guest.new(email: "admin@gmail.com")
        assert_not guest2.save
    end
end