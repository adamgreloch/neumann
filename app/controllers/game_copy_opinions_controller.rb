class GameCopyOpinionsController < ApplicationController
  before_action :set_game_copy_opinion, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /user_opinions or /user_opinions.json
  def index
    @game_copy_opinions = GameCopyOpinion.all
  end

  # GET /game_copy_opinions/1 or /game_copy_opinions/1.json
  def show
  end

  # GET /game_copy_opinions/new
  def new
    @game_copy_opinion = GameCopyOpinion.new
    @opinion_about = GameCopy.find(params[:opinion_about_id])
  end

  # GET /game_copy_opinions/1/edit
  def edit
  end

  # TODO clean up this mess

  # POST /game_copy_opinions or /game_copy_opinions.json
  def create
    @game_copy_opinion = GameCopyOpinion.new(game_copy_opinion_params)

    respond_to do |format|
      if @game_copy_opinion.save
        format.html { redirect_to game_copy_url(@game_copy_opinion.opinion_about), notice: "Game copy opinion was successfully submitted." }
        format.json { render :show, status: :created, location: @game_copy_opinion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game_copy_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_copy_opinions/1 or /game_copy_opinions/1.json
  def update
    respond_to do |format|
      if @game_copy_opinion.update(game_copy_opinion_params)
        format.html { redirect_to game_copy_url(@game_copy_opinion.opinion_about), notice: "Game copy opinion was successfully submitted." }
        format.json { render :show, status: :ok, location: @game_copy_opinion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game_copy_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_copy_opinions/1 or /game_copy_opinions/1.json
  def destroy
    @game_copy_opinion.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Game copy opinion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_copy_opinion
      @game_copy_opinion = GameCopyOpinion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_copy_opinion_params
      params.require(:game_copy_opinion).permit(:opinion_by_id, :opinion_about_id, :condition)
    end
end
