class UsersController < ApplicationController

  before_action :signed_in_user,only:[:edit,:update]
  before_action :correct_user,only:[:edit,:update]

  def new
  	@user=User.new
  end

  def create
  	@user=User.new(user_params)	
  	if @user.save
      sign_in @user
      flash[:success]="Welcome to the Bingwen Yuan"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
  
  def edit
   @user=User.find(params[:id]) 
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user  
      flash[:success]="资料更新成功"
    else
      render 'edit' 
    end
    
  end
  
  def show
  	@user=User.find(params[:id])	
  end

  private

  def user_params
  	params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:warning]="please sign in"
      redirect_to signin_url
    end
  end

  def correct_user
    @user=User.find(params[:id]) 
    redirect_to(root_url) unless current_user?(@user)
  end

end
