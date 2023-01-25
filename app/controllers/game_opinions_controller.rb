class GameOpinionsController < ApplicationController
  before_action :set_game_opinion, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /user_opinions or /user_opinions.json
  def index
    @game_opinions = GameOpinion.all
  end

  # GET /game_opinions/1 or /game_opinions/1.json
  def show
  end

  # GET /game_opinions/new
  def new
    @game_opinion = GameOpinion.new
    @opinion_about = Game.find(params[:opinion_about_id])
  end

  # GET /game_opinions/1/edit
  def edit
    @opinion_about = @game_opinion.opinion_about
  end

  # TODO clean up this mess

  # POST /game_opinions or /game_opinions.json
  def create
    @game_opinion = GameOpinion.new(game_opinion_params)
    @opinion_about = @game_opinion.opinion_about

    respond_to do |format|
      if @game_opinion.save
        format.html { redirect_to game_url(@opinion_about), notice: "Game copy opinion was successfully submitted." }
        format.json { render :show, status: :created, location: @game_opinion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_opinions/1 or /game_opinions/1.json
  def update
    respond_to do |format|
      if @game_opinion.update(game_opinion_params)
        format.html { redirect_to game_url(@game_opinion.opinion_about), notice: "Game copy opinion was successfully submitted." }
        format.json { render :show, status: :ok, location: @game_opinion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_opinions/1 or /game_opinions/1.json
  def destroy
    @game_opinion.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Game copy opinion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_opinion
      @game_opinion = GameOpinion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_opinion_params
      params.require(:game_opinion).permit(:opinion_by_id, :opinion_about_id,
                                           :rating, :weight, :playing_time, :min_players,
                                           :max_players, :comment)
    end
end
