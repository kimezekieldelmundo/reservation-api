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
        reservation = Reservation.find_by(id: params[:id])
        if reservation.present?
            render json: reservation.to_json
        else
            render json: reservation.to_json, status: 404
        end
    end
end
