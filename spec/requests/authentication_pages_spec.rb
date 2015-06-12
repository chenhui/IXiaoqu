require 'rails_helper'
require_relative '../support/utilities'

RSpec.describe "AuthenticationPages", :type => :request do

	subject { page }

	describe "signin page" do
		before { visit signin_path }


		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user)}
			before do
				sign_in user
			end
			
			it {should have_title(user.name)}
			it {should have_link('个人资料',href:user_path(user))}
			it {should have_link('用户',href:users_path) }
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

	describe "authorization" do

		describe "for non-signed-in users"	do
			let(:user)	{ FactoryGirl.create(:user)}

			describe "in the users controller" do

				describe "visiting the edit page" do
					before{ visit edit_user_path(user)}	
					it {should have_title('登录')}
				end

				describe "submitting to the update action" do
					before { patch user_path(user)}	
					specify { expect(response).to redirect_to(signin_path)}
				end
				
				describe "visiting the user index" do
					before { visit users_path }
					it { should have_title('登录') }
				end
			end

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in  "邮件",with:user.email
					fill_in  "密码",with:user.password
					click_button "登录"
				end

				describe "after signing in" do
					it "should render the described protected page" do
						expect(page).to have_title('Edit user')
					end

				end

			end

		end


		describe "as wrong user" do

			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email:"wrong@example.com") }
			before { sign_in user, no_capybara: true }

			describe "submitting a GET request to the Users#edit action" do

				before { get edit_user_path(wrong_user) }
				specify { expect(response.body).not_to match(full_title('Edit user'))
				}
				specify { expect(response).to redirect_to(root_url) }
			end


			describe "submitting a PATCH request to the Users#update action" do
				before { patch user_path(wrong_user) }
				specify { expect(response).to redirect_to(root_url) }
			end
		end
		
		describe "as non-admin user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:non_admin) {FactoryGirl.create(:user) }
			before {sign_in non_admin,no_capybara: true }
			
			describe "submitting a DELETE request to the User#destroy action" do
				before { delete user_path(user) }
				specify {expect(response).to redirect_to(root_url)}
			end
			
		end

	end


end

