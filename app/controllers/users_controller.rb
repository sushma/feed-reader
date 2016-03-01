class UsersController < ApplicationController
	before_action :get_user, only: [:edit, :update]
	
	# GET /users/new
	def new
		@user = User.new
	end

	# GET /users/1/edit
	def edit
	end
  
	# POST /users
	def create
		@user = User.new(user_params)
		return render :new unless @user.valid?
		@user.save
		session[:user_id] = @user.id
		redirect_to root_path, notice: 'User was successfully created.'
	end
	
	# PATCH/PUT /users/1
	def update
		if @user.update(user_params)
			redirect_to root_path, notice: 'User was successfully updated.'
		else
			render :edit 
		end
	end
		
	#############
	private
	#############
	
	def get_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
	
end
