class UsersController < ApplicationController

	before_action :authenticate_user!
	def index
		@book = Book.new
		@users = User.all
		# @books = Book.where(user_id: "")
		@user = current_user
	end

	def show
		@user = User.find(params[:id])
		@books = @user.books
		@newbook = Book.new
	end

	def edit
		if current_user != User.find(params[:id])
		   redirect_to user_path(current_user)
		end
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   flash[:notice] = "update successfully!"
		   redirect_to user_path(current_user)
		else
			flash[:notice] = "error, update failed"
			redirect_to edit_user_path(current_user)
	    end
	end

	private
	def user_params
		params.require(:user).permit(:name, :avatar_image, :self_introduction_text)
	end
	def book_params
		params.require(:book).permit(:title, :opinion)
	end
end
