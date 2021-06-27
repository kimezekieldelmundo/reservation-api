module AppServices
    module ReservationImport
        module ReservationImporter
            class << self
                def import(params)
                    Rails.logger.info '[ReservationImporter] Importing reservation'
                    normalized_params = normalize_params(params.deep_symbolize_keys)
                    guest_id = normalized_params.fetch(:guest_id)
                    reservation = nil
                    ApplicationRecord.transaction do 
                        guest = Guest.find_by(id: guest_id)
                        guest_attrs = normalized_params.dig(:guest_attributes)
                        if guest.present?
                            begin
                                Rails.logger.info "[ReservationImporter] found a Guest with id=#{guest_id}. Updating guest"
                                guest.update!(guest_attrs)
                                Rails.logger.info "[ReservationImporter]Guest with id=#{guest_id} updated"
                            rescue ActiveRecord::RecordInvalid => e
                                raise ReservationImportError.new("Failed to update Guest with id=#{guest_id} because: #{e.message}")
                            end
                        else
                            begin
                                Rails.logger.info "[ReservationImporter] Unable to find a Guest with id=#{guest_id}. Creating new Guest..."
                                Guest.create!(guest_attrs)
                                Rails.logger.info "[ReservationImporter] Created new Guest"
                            rescue ActiveRecord::RecordInvalid => e
                                raise ReservationImportError.new("Failed to create Guest with id=#{guest_id} because: #{e.message}")
                            end
                        end
                        normalized_params.delete(:guest_attributes)
                        begin
                            Rails.logger.info "[ReservationImporter] Creating new Reservation#{normalized_params}"
                            reservation = Reservation.create!(normalized_params)
                            Rails.logger.info "[ReservationImporter] Create new Reservation with id=#{reservation.id}"
                        rescue ActiveRecord::RecordInvalid => e
                            raise ReservationImportError.new("Failed to create Reservation because: #{e.message}")
                        end
                        reservation
                    end
                end
                
                # normalizes reservation params of different formats
                # @param [Hash] reservation data
                def normalize_params(params)
                    formats = ReservationData::FORMATS
                    data = nil
                    formats.each do |format|
                        data = nil
                        begin
                            Rails.logger.info("[ReservationImporter#normalize_params] Matching with #{format}")
                            data = format.new(params)
                            break if data.present?
                        rescue ArgumentError => e
                        end
                    end
                    if data.blank?
                        raise ReservationImportError.new("Uknown information format")
                    end
                    data.normalized_data
                end
            end
        end
    end
end