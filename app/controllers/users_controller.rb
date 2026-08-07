class UsersController < ApplicationController

  allow_unauthenticated_access only: [:new, :create] #認証スキップ

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path notice: "successfully"#後で変更するよユーザー詳細画面へ
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
