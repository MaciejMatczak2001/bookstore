class BooksController < ApplicationController
  include Available
  before_action :set_book, only: %i[show edit update destroy author]
  before_action :admin_content, only: %i[destroy edit update]

  def index
    @books = Book.all
  end

  def show
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to root_path, notice: "Book was successfully edited"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to root_path, notice: "Book was successfully deleted"
  end

private

  def book_params
    params.permit(:title, :price, :published)
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
