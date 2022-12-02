class HeroPowersController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessible_entity_response

    def create
        hero_power = HeroPower.create!(hero_power_params)
        render json: hero_power.hero, serializer: HeroPowerSerializer, status: :created
    end

    private

    def hero_power_params
        params.permit(:strength, :power_id, :hero_id)
    end

    def render_unprocessible_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :not_found
    end
end  