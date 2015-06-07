require 'rails_helper'

RSpec.describe "AuthenticationPages", :type => :request do

	subject { page }
	describe "signin page" do
		before { visit signin_path }


		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user)}
			before do
				fill_in  "邮件"	,with: user.email.upcase
				fill_in  "密码",with:user.password

				click_button "登录"
			end
			
			it {should have_title(user.name)}
			it {should have_link('个人资料',href:user_path(user))}
			it {should have_link('退出',href:signout_path)}
			it {should_not have_link('登录',href:signin_path)}

			describe "followed by signout" do 
				before { click_link "退出"}
				it { should have_link('登录')}
					
			end
			
		end

		it { should have_content('登录')}
		it { should have_title("登录")}

		describe "with invalid information" do
			before { click_button "登录"}
			it { should have_selector('div.alert.alert-danger')}

			describe "after visiting another page" do 
				before { click_link '首页'}
				it { should_not  have_selector('div.alert.alert-danger')}
				
			end
		end
		
	end
end

