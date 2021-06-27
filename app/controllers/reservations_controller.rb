class ReservationsController < ApplicationController
    # disable authenticity token verification
    skip_before_action :verify_authenticity_token

    def import
        data = params.to_unsafe_hash
        reservation = AppServices::ReservationImport::ReservationImporter.import(data)
        render json: {
            sucess: true,
            reservation: reservation.to_json
        }
    rescue AppServices::ReservationImport::ReservationImportError => e
        render json: {
            succes: false,
            error_message: e.message
        }
    end

    def show
        render json: Reservation.find(params[:id]).to_json
    end
end
