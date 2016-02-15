class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action :restrict_signup, only: [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Thanks for signing up. Welcome to PMTools!"
    else
      flash[:alert] = "Signup was unsuccessful, please try again"
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update user_params
      redirect_to user_path(@user), notice: "Account updated"
    else
      render :edit
    end
  end

  private

  def find_user
    # @user ||= User.find params[:id]
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
                            :first_name,
                            :last_name,
                            :email,
                            :password,
                            :password_confirmation)
  end

  def restrict_signup
    redirect_to root_path if user_signed_in?
  end
end
