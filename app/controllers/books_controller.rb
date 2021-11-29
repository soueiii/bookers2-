class BooksController < ApplicationController
 def new
  @book = Book.new
 end

 def create

 @user = current_user
 @books = Book.all
 @book = Book.new(book_params)
 @book.user_id = current_user.id
  if @book.save
   redirect_to book_path(@book), notice: 'successfully'
  else
   flash.now[:alert] = 'error'
   render :index
  end
 end

 def show
  @booknew = Book.new
  @book = Book.find(params[:id])
  @user = @book.user
 end

 def index
  @user = current_user
  @books = Book.all
  @users = User.all
  @book = Book.new
 end

 def edit
  @user = current_user
  @book = Book.find(params[:id])
  if @book.user == current_user
     render "edit"
  else
   redirect_to books_path
  end
 end

 def update
  @books = Book.all
  @user = current_user
  @book = Book.find(params[:id])
  if
   @book.update(book_params)
   redirect_to book_path(@book), notice: 'successfully'
  else
   flash.now[:alert] = 'error'
   render :edit
  end
 end

 def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
 end

 private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
