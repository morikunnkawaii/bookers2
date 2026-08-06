class BooksController < ApplicationController
  def index
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id
    @book.save
    redirect_to books_path
  end

  def show
  end
end

private

def book_params
  params.require(:book).permit(:title, :body)
end
