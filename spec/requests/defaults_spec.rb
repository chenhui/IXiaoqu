require 'rails_helper'

RSpec.describe "Defaults", :type => :request do

  subject { page }
  
  let(:base_title){ "滨文苑" }

  describe "Home page" do
		before{ visit home_path }	    	 
   	it { should  have_selector('h1',text:'首页') }
    it { should  have_title("#{base_title}|首页")}
  end

  describe "Help page" do
  	before { visit help_path }
  	it { should have_selector('h1',text:'帮助')}
    it { should  have_title("#{base_title}|帮助")}
  end

  describe "About page" do
    before { visit about_path }
    it { should have_selector('h1', text: '关于我们')}
    it { should  have_title("#{base_title}|关于我们")}
  end


  describe "Contact us page" do
    before { visit contact_path }
    it { should have_selector('h1',text:'联系我们')}
    it { should  have_title("#{base_title}|联系我们")}
  end

end
