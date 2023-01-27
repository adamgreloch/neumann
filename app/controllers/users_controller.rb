class UsersController < ApplicationController
  before_action :set_user, only: %i[show star edit update destroy]
  before_action :authenticate_user!
  before_action :force_to_pay, only: %i[star edit update destroy]

  def index
    @users = User.all
  end

  def show
  end

  # GET /users/1/edit
  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :deposit_paid, :deposit_deducted)
  end
end
