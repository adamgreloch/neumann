class OfferedPerRequestsController < ApplicationController
  before_action :set_rental_request
  before_action :authenticate_user!

  def new
    @offered_per_request = OfferedPerRequest.new
  end

  def create
    @rental_request = RentalRequest.find(params[:rental_request_id])

    @rental_request.offered_per_requests << OfferedPerRequest.create(rental_request_id: @rental_request.id,
                                                                     game_id: params[:game_id])

    respond_to do |format|
      if @rental_request.save
        format.html { redirect_back_or_to games_url, notice: "Offered game added to request ##{@rental_request.id}." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @offered_per_request = OfferedPerRequest.find(params[:id])
    @offered_per_request.destroy

    respond_to do |format|
      format.html { redirect_back_or_to games_url, notice: "Offered game removed from request ##{@rental_request.id}." }
    end
  end

  private

  def set_rental_request
    @rental_request = RentalRequest.find(params[:rental_request_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_offered_per_request
    @offered_per_request = OfferedPerRequest.find(params[:rental_request])
  end

  # Only allow a list of trusted parameters through.
  def offered_per_request_params
    params.require(:offered_per_request).permit(:rental_request_id, :game_id)
  end
end
