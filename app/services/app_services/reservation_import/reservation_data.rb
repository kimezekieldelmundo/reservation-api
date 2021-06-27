
module AppServices
    module ReservationImport
        class ReservationData
            DATE_FORMAT = '%Y-%m-%d'
            FORMATS = [ReservationDataFormat1, ReservationDataFormat2]
            
            attr_accessor :start_date,:end_date,:nights,:guests,:adults,:children,:infants,:status,:guest_id,:currency,:payout_price,:security_price,:total_price, :localized_description, :guest_id, :guest_first_name, :guest_last_name, :guest_phone, :guest_phone, :guest_email
            
            def normalized_data
                {
                    start_date: @start_date,
                    end_date: @end_date,
                    nights: @nights,
                    guests: @guests,
                    adults: @adults,
                    children: @children,
                    infants: @infants,
                    status: @status,
                    currency: @currency,
                    payout_price: @payout_price,
                    security_price: @security_price,
                    total_price: @total_price,
                    guest_id: @guest_id,
                    localized_description: @localized_description,
                    guest_attributes: {
                        id: @guest_id,
                        first_name: @guest_first_name,
                        last_name: @guest_last_name,
                        email: @guest_email,
                        phone: @guest_phone
                    }
                }.compact
            end
        end
    end
end
