
module AppServices
    module ReservationImport
        # takes in reservation data in format1 and returns as normalized data
        class ReservationDataFormat1 < ReservationData
            def initialize(**params)
                @start_date = Date.strptime(params.fetch(:start_date) , DATE_FORMAT)
                @end_date = Date.strptime(params.fetch(:end_date) , DATE_FORMAT)
                @nights =   params.fetch(:nights).to_i
                @guests =  params.fetch(:guests).to_i
                @adults =  params.fetch(:adults).to_i
                @children =  params.fetch(:children).to_i
                @infants =  params.fetch(:infants).to_i
                @status =  params.fetch(:status)
                @currency =  params.fetch(:currency)
                @payout_price =  params.fetch(:payout_price)
                @security_price =  params.fetch(:security_price)
                @total_price =  params.fetch(:total_price)
                guest_params = params.fetch(:guest)
                @guest_id = guest_params.fetch(:id).to_i
                @guest_first_name = guest_params.fetch(:first_name)
                @guest_last_name = guest_params.fetch(:last_name)
                @guest_email = guest_params.fetch(:email)
                @guest_phone = [guest_params.fetch(:phone)]
            rescue KeyError => e
                raise ArgumentError.new("invalid fields")
            end
        end
    end
end