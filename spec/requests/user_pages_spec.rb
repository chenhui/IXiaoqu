require 'rails_helper'

RSpec.describe "UserPages", :type => :request do

	subject{page}

	describe  "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		it { should have_content(user.name)}
		it { should have_title(user.name)}	
	end


end
