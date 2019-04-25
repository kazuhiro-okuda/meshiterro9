class BooksController < ApplicationController

	before_action :authenticate_user!

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@newbook = Book.new
		@book = Book.find(params[:id])
		@user = @book.user
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "Update successfully!"
			redirect_to book_path(@book.id)
		else
			flash[:notice] = "error, Update failed"
			redirect_to edit_book_path(@book.id)
		end
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "save successfully!"
			redirect_to book_path(@book.id)
		else
			flash[:notice] = "error, save failed"
			@books = Book.all
			@newbook = Book.new
			@user = current_user
			render :index
		end
	end

	def destroy
		book = Book.find(params[:id])

		if book.destroy
			flash[:notice] = "destroy successfully!"
			redirect_to books_path
		else
			flash[:notice] = "destroy failed"
			redirect_to books_path
		end
	end

	private

	def book_params
		params.require(:book).permit(:title, :opinion)
	end

	def user_params
		params.require(:user).permit(:name, :avatar_image_id, :self_introduction_text)
	end
end
