class GuestsController < ApplicationController
    # disable authenticity token verification
    skip_before_action :verify_authenticity_token

    def show
        render json: Guest.find(params[:id]).to_json
    end
end