class Relationship < ActiveRecord::Base
    belongs_to :follower,class_name:"User"
    belongs_to :followed,class_name:"User"
    validates :follower_id,presence:true
    validates :followed_id,presence:true
    
    def create
        @user=User.find(params[:relationship][:followed_id])
        current_user.follow!(@user)
        redirect_to  @user
    end  
    
end
