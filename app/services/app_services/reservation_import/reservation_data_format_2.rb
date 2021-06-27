module AppServices
    module ReservationImport
        # takes in reservation data in format2 and returns as normalized data
        class ReservationDataFormat2 < ReservationData
            def initialize(**params)
                reservation = params.fetch(:reservation)
                @start_date = Date.strptime(reservation.fetch(:start_date) , DATE_FORMAT)
                @end_date = Date.strptime(reservation.fetch(:end_date) , DATE_FORMAT)
                @payout_price =  reservation.fetch(:expected_payout_amount)
                @nights =   reservation.fetch(:nights).to_i
                @status =  reservation.fetch(:status_type)
                @currency =  reservation.fetch(:host_currency)
                @security_price =  reservation.fetch(:listing_security_price_accurate)
                @total_price =  reservation.fetch(:total_paid_amount_accurate)
                @guests =  reservation.fetch(:number_of_guests)
                guest_details = reservation.fetch(:guest_details)
                @adults =  guest_details.fetch(:number_of_adults).to_i
                @children =  guest_details.fetch(:number_of_children).to_i
                @infants =  guest_details.fetch(:number_of_infants).to_i
                @localized_description = guest_details.fetch(:localized_description)
                @guest_id = reservation.fetch(:guest_id).to_i
                @guest_first_name = reservation.fetch(:guest_first_name)
                @guest_last_name = reservation.fetch(:guest_last_name)
                @guest_email = reservation.fetch(:guest_email)
                @guest_phone = reservation.fetch(:guest_phone_numbers)
            rescue KeyError => e
                raise ArgumentError.new("invalid fields")
            end
        end
    end
end
