class WantedPerRequestsController < ApplicationController
  before_action :set_rental_request
  before_action :authenticate_user!

  def new
    @wanted_per_request = WantedPerRequest.new
  end

  def create
    @rental_request.wanted_per_requests << WantedPerRequest.create(rental_request_id: @rental_request.id, game_id: params[:game_id])

    respond_to do |format|
      if @rental_request.save
        format.html { redirect_back_or_to games_url, notice: "Wanted game added to request ##{@rental_request.id}." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @wanted_per_request = WantedPerRequest.find(params[:id])
    @wanted_per_request.destroy

    respond_to do |format|
      format.html { redirect_back_or_to games_url, notice: "Wanted game removed from request ##{@rental_request.id}." }
    end
  end

  private

  def set_rental_request
    @rental_request = RentalRequest.find(params[:rental_request_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_wanted_per_request
    @wanted_per_request = WantedPerRequest.find(params[:rental_request])
  end

  # Only allow a list of trusted parameters through.
  def wanted_per_request_params
    params.require(:wanted_per_request).permit(:rental_request_id, :game_id)
  end
end
