class BooksController < ApplicationController

  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
   if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to "/books/#{@book.id}"
   else
      render :index
   end

  end

  
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end
  
   def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
   end
    

   def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
   end



private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end