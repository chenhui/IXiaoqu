require 'rails_helper'

RSpec.describe "MicropostPages", :type => :request do
  
  subject { page }
  let(:user){FactoryGirl.create(:user)}
  before { sign_in  user }
  
  describe "micropost creation" do
    before{ visit root_path }
    
    describe "with invalid information" do
      it "should not create a micropost" do
        expect{ click_button "提交"}.not_to  change(Micropost,:count)
      end
    
    describe "empty message" do
      before {click_button "提交" }
      it {should  have_content('be blank')}
    end
   end 
   
   
   describe "with valid information" do
     before{ fill_in 'micropost_content',with:"test micropost" }
     it "should create a micropost" do
       expect { click_button "提交"}.to change(Micropost,:count).by(1)
     end
   end
 end    
 
 describe "micropost destroy" do
   before{ FactoryGirl.create(:micropost,user: user) }
   
   describe "as correct user" do
     before{visit root_path}
     it "should delete a micropost"  do
       expect{click_link "删除"}.to change(Micropost,:count).by(-1)
     end
   end
   
 end
 
 
 
end
