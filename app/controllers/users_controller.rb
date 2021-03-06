class UsersController < ApplicationController

  before_action :signed_in_user,only:[:index,:edit,:update,:destroy,:following,:followers]
  before_action :correct_user,only:[:edit,:update]
  before_action :admin_user, only:[:destroy]
  
  def following
    @title="Following" 
    @user=User.find(params[:id])
    @users=@user.followed_users.paginate(page:params[:page])
    render "show_follow"
  end
  
  def followers
    @title="Followers" 
    @user=User.find(params[:id])
    @users=@user.followers.paginate(page:params[:page])
    render "show_follow"
  end

  def new
  	@user=User.new
  end

  def index
    @users=User.paginate(page:params[:page],per_page:10) 
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
  	@microposts=@user.microposts.paginate(page:params[:page])
  end
  
  def destroy
   User.find(params[:id]).destroy
   flash[:warning]="用户已经删除"
   redirect_to users_url
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
  
  def admin_user
    redirect_to(root_url)  unless  current_user.admin?
  end

end
