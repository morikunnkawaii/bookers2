class BooksController < ApplicationController
  def index
    @booknew = Book.new
    @books = Book.all
    @booknew.user_id = Current.user.id
    @user = Current.user
  end

  def create
    @booknew = Book.new(book_params)
    @booknew.user_id = Current.user.id
    if @booknew.save
      flash[:notice] = "You have created book successfully"
      redirect_to book_path(@booknew.id)
    else
      @user = Current.user
      @books = Book.all
      count = @booknew.errors.count
      error_header = view_context.pluralize(count, "error") + " prohibited this book from being saved:" #view_context.pluralizeでveiwのpluralizeメソッドと同じことが出来る
      error_messages = @booknew.errors.full_messages.join(",")
      flash[:alert] = "#{error_header} #{error_messages}"
      redirect_to books_path
    end
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    is_matiching_login_user
    @book = Book.find(params[:id])
  end

  def update
    is_matiching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully"
      redirect_to book_path(@book.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
   
  def is_matiching_login_user
    user = Book.find(params[:id])
    unless user.user_id == Current.user.id
      redirect_to books_path
    end
  end
end
# @book.user_id = Current.user.id これを使うことによってuser modelからひっぱてこれた