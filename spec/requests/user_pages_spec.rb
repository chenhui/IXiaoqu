require 'rails_helper'

RSpec.describe "User pages", :type => :request do

	subject{page}

	describe  "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		it { should have_content(user.name)}
		it { should have_title(user.name)}	
	end

	describe "signup" do

		before { visit signup_path }	
		let(:submit){"提交"}

		describe "with invalid information"	 do
			it "should not create a user"	do
				expect {click_button submit }.not_to change(User,:count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "姓名"	,with:"chenhui"
				fill_in "邮件",with:"chenhui@sohu.com"
				fill_in "密码",with:"foobar"
				fill_in "确认密码",with:"foobar"
			end

			it "should create a user" do
				expect{ click_button submit }.to change(User,:count).by(1)
			end

			describe "after saving the user" do
				before { click_button  submit}	
				let(:user) { User.find_by(email:'chenhui@sohu.com')}

				it { should have_link('退出') }
				it { should have_title(user.name) }
				it { should have_selector('div.alert.alert-success',text:'Welcome')}
			end
			
		end
	end
	
	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			visit edit_user_path(user) 
		end 
		
			
		describe "page" do
			it { should have_content("编辑个人资料") }
			it { should have_title("Edit user") }
			it { should have_link('change', href: 'http://gravatar.com/emails') }
		end
		
		describe "with invalid information" do
			before  { click_button "保存" }
			it { should have_content("short") }
		end
	end

end
