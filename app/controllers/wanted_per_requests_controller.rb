class WantedPerRequestsController < ApplicationController
  def new
    @wanted_per_request = WantedPerRequest.new
  end

  def create
    @rental_request = RentalRequest.find(params[:rental_request_id])

    @rental_request.wanted_per_requests << WantedPerRequest.create(rental_request_id: @rental_request.id, game_id: params[:game_id])

    respond_to do |format|
      if @rental_request.save
        format.html { redirect_to home_index_url, notice: "Wanted games added to request." }
        format.json { render :show, status: :created, location: @wanted_per_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wanted_per_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @wanted_per_request = WantedPerRequest.find(params[:id])
    @wanted_per_request.destroy

    respond_to do |format|
      format.html { redirect_to rental_request_url, notice: "Rental request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wanted_per_request
      @wanted_per_request = WantedPerRequest.find(params[:rental_request])
    end

    # Only allow a list of trusted parameters through.
    def wanted_per_request_params
      params.require(:wanted_per_request).permit(:rental_request_id, :game_id)
    end
end
