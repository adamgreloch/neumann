class GameCopiesController < ApplicationController
  before_action :set_game_copy, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /game_copies or /game_copies.json
  def index
    @game_copies = GameCopy.all
  end

  # GET /game_copies/1 or /game_copies/1.json
  def show
  end

  # GET /game_copies/new
  def new
    @game_copy = GameCopy.new
    @game = Game.find(params[:game_id])
  end

  # GET /game_copies/1/edit
  def edit
  end

  # POST /game_copies or /game_copies.json
  def create
    @game_copy = GameCopy.new(game_copy_params)
    @game_copy.realizes.game_copies << @game_copy

    respond_to do |format|
      if @game_copy.save
        format.html { redirect_to game_copy_url(@game_copy), notice: "Game copy was successfully created." }
        format.json { render :show, status: :created, location: @game_copy }
      else
        format.html { redirect_to root_path, notice: "Failed to create game copy." }
        format.json { render json: @game_copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_copies/1 or /game_copies/1.json
  def update
    respond_to do |format|
      if @game_copy.update(game_copy_params)
        format.html { redirect_to game_copy_url(@game_copy), notice: "Game copy was successfully updated." }
        format.json { render :show, status: :ok, location: @game_copy }
      else
        format.html { redirect_to root_path, notice: "Failed to update game copy." }
        format.json { render json: @game_copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_copies/1 or /game_copies/1.json
  def destroy
    @game_copy.destroy

    respond_to do |format|
      format.html { redirect_back_or_to root_url, notice: "Game copy was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_copy
      @game_copy = GameCopy.find(params[:id])
      @game = @game_copy.realizes
    end

    # Only allow a list of trusted parameters through.
    def game_copy_params
      params.require(:game_copy).permit(:owner_id, :realizes_id, :condition, :description, :barcode)
    end
end
