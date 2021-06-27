class GuestsController < ApplicationController
    # disable authenticity token verification
    skip_before_action :verify_authenticity_token

    def show
        guest = Guest.find_by(id: params[:id])
        if guest.present?
            render json: guest.to_json
        else
            render json: guest.to_json, status: 404
        end
    end
end