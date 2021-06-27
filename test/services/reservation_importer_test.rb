class ReservationImporterTest < ActiveSupport::TestCase
   test "import_with_format1" do
    data = {
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "guest": {
            "id": 1,
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
        },
        "currency": "AUD",
        "payout_price": "3800.00",
        "security_price": "500",
        "total_price": "4500.00"
    }
    expected_reservation =  {
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "currency": "AUD",
        "payout_price": "3800.00",
        "security_price": "500",
        "total_price": "4500.00",
        "guest_id": 1,
        "localized_description": nil
    }.deep_symbolize_keys

    expected_guest = {
            "id": 1,
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": ["639123456789"],
            "email": "wayne_woodbridge@bnb.com"
    }.deep_symbolize_keys

    reservation = AppServices::ReservationImport::ReservationImporter.import(data)
    guest = reservation.guest
    reservation = reservation.to_json
    reservation.delete(:id)
    guest = guest.to_json

    assert_equal expected_reservation, reservation
    assert_equal expected_guest, guest
   end

   test "import_with_format2" do
    data = {
        "reservation": {
            "start_date": "2021-03-12",
            "end_date": "2021-03-16",
            "expected_payout_amount": "3800.00",
            "guest_details": {
                "localized_description": "4 guests",
                "number_of_adults": 2,
                "number_of_children": 2,
                "number_of_infants": 0
            },
            "guest_email": "wayne_woodbridge@bnb.com",
            "guest_first_name": "Wayne",
            "guest_id": 1,
            "guest_last_name": "Woodbridge",
            "guest_phone_numbers": [
                "639123456789",
                "639123456789"
            ],
            "listing_security_price_accurate": "500.00",
            "host_currency": "AUD",
            "nights": 4,
            "number_of_guests": 4,
            "status_type": "accepted",
            "total_paid_amount_accurate": "4500.00"
        }
    }
    expected_reservation =  {
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "currency": "AUD",
        "payout_price": "3800.00",
        "security_price": "500.00",
        "total_price": "4500.00",
        "guest_id": 1,
        "localized_description": "4 guests"
    }.deep_symbolize_keys

    expected_guest = {
            "id": 1,
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": [
                "639123456789",
                "639123456789"
            ],
            "email": "wayne_woodbridge@bnb.com"
    }.deep_symbolize_keys

    reservation = AppServices::ReservationImport::ReservationImporter.import(data)
    guest = reservation.guest
    reservation = reservation.to_json
    reservation.delete(:id)
    guest = guest.to_json

    assert_equal expected_reservation, reservation
    assert_equal expected_guest, guest
   end

end