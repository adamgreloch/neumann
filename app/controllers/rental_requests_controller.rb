class RentalRequestsController < ApplicationController
  before_action :set_rental_request, only: %i[ show edit update destroy ]

  # GET /rental_requests or /rental_requests.json
  def index
    @rental_requests = RentalRequest.all
  end

  # GET /rental_requests/1 or /rental_requests/1.json
  def show
  end

  # GET /rental_requests/new
  def new
    @rental_request = RentalRequest.new
  end

  # GET /rental_requests/1/edit
  def edit
  end

  # POST /rental_requests or /rental_requests.json
  def create
    @rental_request = RentalRequest.new(rental_request_params)

    respond_to do |format|
      if @rental_request.save
        format.html { redirect_to rental_request_url(@rental_request), notice: "Rental request was successfully created." }
        format.json { render :show, status: :created, location: @rental_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rental_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rental_requests/1 or /rental_requests/1.json
  def update
    respond_to do |format|
      if @rental_request.update(rental_request_params)
        format.html { redirect_to rental_request_url(@rental_request), notice: "Rental request was successfully updated." }
        format.json { render :show, status: :ok, location: @rental_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rental_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rental_requests/1 or /rental_requests/1.json
  def destroy
    @rental_request.destroy

    respond_to do |format|
      format.html { redirect_to rental_requests_url, notice: "Rental request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental_request
      @rental_request = RentalRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rental_request_params
      params.fetch(:rental_request, {})
    end
end
