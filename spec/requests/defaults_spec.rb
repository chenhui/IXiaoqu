require 'rails_helper'

RSpec.describe "Defaults", :type => :request do

  subject { page }
  
  let(:base_title){ "滨文苑" }

  describe "Home page" do
		before{ visit home_path }	    	 
   	it { should  have_selector('h1',text:'首页') }
    it { should  have_title("#{base_title}|首页")}
    
    
    describe "for signed-in users" do
      let(:user){FactoryGirl.create(:user)}
      before do
        FactoryGirl.create(:micropost,user:user,content:"Lorem ipsum")
        FactoryGirl.create(:micropost,user:user,content:"Dolor sit amet")
        sign_in user
        visit root_path
      end
      
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}",text:item.content)
        end
      end
      
     describe "follower/following counts" do
       let(:other_user){FactoryGirl.create(:user)}
       before do
          other_user.follow!(user)
          visit root_path
       end
        it {should have_link("0 following",href:following_user_path(user)) }
        it {should have_link("1 followers",href:followers_user_path(user)) }
     end     
  end
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
