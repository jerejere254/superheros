class PowersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_nor_found_response
        rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessible_entity_response
        
            def index
                render json: Power.all, status: :ok
            end
        
            def show
                power = find_power
                render json: power
            end
        
            def update
                power = find_power
                power.update!(update_powers_params)
                render json: power
            end
        
            private
            def render_nor_found_response
                render json: {"error": "Power not found"}, status: :not_found
            end
        
            def find_power
                Power.find(params[:id])
            end
        
            def update_powers_params
                params.permit(:description)
            end
        
            def render_unprocessible_entity_response(invalid)
                render json: {errors: invalid.record.errors.full_messages}, status: :not_found
            end
end