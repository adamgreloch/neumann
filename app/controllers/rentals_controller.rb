class RentalsController < ApplicationController
  before_action :set_rental, only: %i[ show edit set_swapped set_finished set_problem accept update destroy ]
  before_action :authenticate_user!
  before_action :force_to_pay

  # GET /rentals or /rentals.json
  def index
    @rentals = Rental.all
  end

  # GET /rentals/1 or /rentals/1.json
  def show
    @rental_request = @rental.realizes
  end

  # GET /rentals/new
  def new
    @rental = Rental.new
    @rental_request = RentalRequest.find(params[:rental_request_id])
  end

  # GET /rentals/1/edit
  def edit
  end

  def accept
    respond_to do |format|
      if @rental.accept(User.find(params[:user_id]));
        format.html { redirect_to rental_url(@rental), notice: "Rental accepted." }
      else
        format.html { redirect_to rental_url(@rental), notice: "Error." }
      end
    end
  end

  def set_swapped
    respond_to do |format|
      if @rental.swap_copies;
        format.html { redirect_to rental_url(@rental), notice: "Rental marked as swapped." }
      else
        format.html { redirect_to rental_url(@rental), notice: "Error." }
      end
    end
  end

  def set_finished
    respond_to do |format|
      if @rental.swap_back_and_finish
        format.html { redirect_to rental_url(@rental), notice: "Rental marked as finished!" }
      else
        format.html { redirect_to rental_url(@rental), notice: "Error." }
      end
    end
  end

  def set_problem
    respond_to do |format|
      if @rental.update(status: "problematic");
        format.html { redirect_to rental_url(@rental), notice: "Rental marked as problematic. Good luck:/" }
      else
        format.html { redirect_to rental_url(@rental), notice: "Error." }
      end
    end
  end

  # POST /rentals or /rentals.json
  def create
    @rental = Rental.new(rental_params)

    respond_to do |format|
      if @rental.save
        format.html { redirect_to rental_url(@rental), notice: "Rental was successfully created." }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1 or /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to rental_url(@rental), notice: "Rental was successfully updated." }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1 or /rentals/1.json
  def destroy
    @rental.destroy

    respond_to do |format|
      format.html { redirect_to rentals_url, notice: "Rental was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rental
    @rental = Rental.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def rental_params
    params.require(:rental).permit(:realizes_id, :accepted_by_id, :status, :accepted_by_status).except(:accept)
  end
end
