class UsersController < ApplicationController

  allow_unauthenticated_access only: [:new, :create] #認証スキップ
  before_action :ensure_guest_user, only: [:edit]

  def new
    if authenticated?
      redirect_to user_path(Current.user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for(@user) #この記述でログインしている状態になる。これがないために、sessionに飛ばされていた
      redirect_to user_path(@user), notice: "Welcome! You have signed up successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    @user = Current.user
    @booknew = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = @user
    @booknew = Book.new #どうやらアソシエーションのおかげか、book.newができる
  end

  def edit
    is_matiching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matiching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully"
      redirect_to user_path(@user.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email_address, :password, :password_confirmation, :profile_image, )
  end

  def is_matiching_login_user
    user = User.find(params[:id])
    unless user.id == Current.user.id
      redirect_to user_path(Current.user.id)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはログイン編集できません"
    end
  end
end
#updateで最初名前しか帰れなかったのは参照するpermitの中に:introduction　:profile_image　が含まれていなかった為