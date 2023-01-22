class UserOpinionsController < ApplicationController
  before_action :set_user_opinion, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /user_opinions or /user_opinions.json
  def index
    @user_opinions = UserOpinion.all
  end

  # GET /user_opinions/1 or /user_opinions/1.json
  def show
  end

  # GET /user_opinions/new
  def new
    @user_opinion = UserOpinion.new
    @opinion_about = User.find(params[:opinion_about_id])
  end

  # GET /user_opinions/1/edit
  def edit
    @opinion_about = @user_opinion.opinion_about
  end

  # POST /user_opinions or /user_opinions.json
  def create
    @user_opinion = UserOpinion.new(user_opinion_params)

    respond_to do |format|
      if @user_opinion.save
        format.html { redirect_to user_path(@opinion_about), notice: "User opinion was successfully submitted." }
        format.json { render :show, status: :created, location: @user_opinion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_opinions/1 or /user_opinions/1.json
  def update
    @opinion_about = @user_opinion.opinion_about

    respond_to do |format|
      if @user_opinion.update(user_opinion_params)
        format.html { redirect_to user_path(@opinion_about), notice: "User opinion was successfully submitted." }
        format.json { render :show, status: :ok, location: @user_opinion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_opinions/1 or /user_opinions/1.json
  def destroy
    @user_opinion.destroy

    respond_to do |format|
      format.html { redirect_to user_opinions_url, notice: "User opinion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_opinion
      @user_opinion = UserOpinion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_opinion_params
      params.require(:user_opinion).permit(:opinion_by_id, :opinion_about_id, :contact_rating, :compliance_rating, :comment)
    end
end
