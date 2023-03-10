class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit update create destroy ]

  # GET /games or /games.json
  def index
    query = @q.result(distinct: true)
    @copies = params[:copies]

    query = query.where.associated(:game_copies) unless @copies.nil?

    @games = query.order(bgg_rating: :desc).paginate(page: params[:page], per_page: 15)
  end

  # GET /games/1 or /games/1.json
  def show
    if @users_request.nil?
      @game_wanted = false
      @game_offered = false
    else
      @game_wanted = @users_request.wanted_per_requests.exists?(game_id: @game.id)
      @game_offered = @users_request.offered_per_requests.exists?(game_id: @game.id)
    end
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: 'Game was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: 'Game was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:title, :bgg_id, :description, :release_year, :bgg_rating,
                                 :bgg_rated_count, :bgg_ranking)
  end
end
