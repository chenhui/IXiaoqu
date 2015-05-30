require 'rails_helper'

RSpec.describe "UserPages", :type => :request do

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
			
		end
	end

end
