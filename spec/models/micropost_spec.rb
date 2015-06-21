require 'rails_helper'

RSpec.describe Micropost, :type => :model do
    
    let(:user) {FactoryGirl.create(:user)}
    
    before  do
       @micropost=user.microposts.build(content:"chenhui")
    end
    
    subject{@micropost}
    
    it {should respond_to(:content)}
    it {should respond_to(:user_id)}
    it {should respond_to(:user) }
    it {expect(@micropost.user).to eq(user)}
    
    describe "when user_id is not present" do
        before{ @micropost.user_id=nil}
        it {should_not be_valid}
    end
    
    describe "when content is null" do 
        before { @micropost.content=" "}
        it {should_not be_valid}
    end 
    
    describe "when content is too long" do
        before { @micropost.content='a'*144 }
        it { should_not be_valid }
    end
    
end
