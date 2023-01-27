class RentalRequestsController < ApplicationController
  before_action :set_rental_request, only: %i[ show edit
    submit reopen remove_offered remove_wanted update destroy ]
  before_action :authenticate_user!
  before_action :force_to_pay

  # GET /rental_requests or /rental_requests.json
  def index
    @rental_requests = RentalRequest.all
  end

  # GET /rental_requests/1 or /rental_requests/1.json
  def show
    @is_submitter = user_signed_in? && @rental_request.submitter_id == current_user.id
  end

  # GET /rental_requests/new
  def new
    @rental_request = RentalRequest.new
  end

  # GET /rental_requests/1/edit
  def edit
  end

  def submit
    respond_to do |format|
      if @rental_request.update(status: 'submitted')
        format.html { redirect_to rental_request_url(@rental_request), notice: 'Rental request submitted.' }
      else
        format.html { redirect_to rental_request_url(@rental_request), notice: 'Failed to submit the request. No idea why. Consult the administrator.' }
      end
    end
  end

  def reopen
    respond_to do |format|
      if @rental_request.update(status: 'open')
        format.html { redirect_to rental_request_url(@rental_request), notice: 'Rental request reopened.' }
      else
        format.html { redirect_to rental_request_url(@rental_request), notice: 'Failed to submit the request. No idea why. Consult the administrator.' }
      end
    end
  end

  def remove_wanted
    respond_to do |format|
      if @rental_request.wanted_per_requests.where(game_id: params[:game_id]).destroy_all
        format.html { redirect_back_or_to games_url, notice: "Wanted game removed from request ##{@rental_request.id}." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def remove_offered
    respond_to do |format|
      if @rental_request.offered_per_requests.where(game_id: params[:game_id]).destroy_all
        format.html { redirect_back_or_to games_url, notice: "Offered game removed from request ##{@rental_request.id}." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # POST /rental_requests or /rental_requests.json
  def create
    @rental_request = RentalRequest.new(rental_request_params)

    respond_to do |format|
      if @rental_request.save
        format.html { redirect_to rental_request_url(@rental_request), notice: 'Rental request was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rental_requests/1 or /rental_requests/1.json
  def update
    respond_to do |format|
      if @rental_request.update(rental_request_params)
        format.html { redirect_to rental_request_url(@rental_request), notice: 'Rental request was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rental_requests/1 or /rental_requests/1.json
  def destroy
    @rental_request.destroy

    respond_to do |format|
      format.html { redirect_to rental_requests_url, notice: 'Rental request was successfully destroyed.' }
    end
  end

  def submitter
    User.find(@rental_request.submitter_id)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rental_request
    @rental_request = RentalRequest.find(params[:id])
    @submitter = @rental_request.submitter
  end

  # Only allow a list of trusted parameters through.
  def rental_request_params
    params.require(:rental_request).permit(:submitter_id, :rental_start, :rental_end, :status, :description)
  end
end
