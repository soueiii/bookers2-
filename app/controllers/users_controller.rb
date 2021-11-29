class UsersController < ApplicationController

 def new
  @book = Book.new
 end

 def create
  @user = User.new
  @book = Book.new(book_params)
  @book.user_id = current_user.id
 if
   @book.save
   redirect_to book_path(@book), notice: 'successfully'
 else
   flash.now[:alert] = 'error'
   render :index
 end
 end

 def show
  @booknew = Book.new
  @user = User.find(params[:id])
  # @book = Book.find(params[:id])
  @books = @user.books

 end

 def index
  @user = current_user
  @books = Book.all
  @users = User.all
  @book = Book.new
 end

 def edit
  @profile_image = User.new
  @user = User.find(params[:id])
  if @user == current_user
  render "edit"
  else
   redirect_to user_path(current_user)
  end
 end

 def update
  @profile_image = User.new
  @user = User.find(params[:id])
  if @user.update(user_params)
   redirect_to user_path(current_user), notice: 'successfully'
  else
   flash.now[:alert] = 'error'
   render :edit
  end
 end

 def create
  user = User.new(user_params)
  if user.save
   redirect_to user_path(current_user), notice: 'successfully'
  else
   flash.now[:alert] = 'error'
   render :index
  end
 end


 private

 def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
 end
end
