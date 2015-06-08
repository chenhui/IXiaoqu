include ApplicationHelper

def sign_in(user,options={})
	if options[:no_capybara]
		remember_token=User.new_remember_token
		cookies[:remember_token]=remember_token
		user.update_attribute(:remember_token,User.encrypt(remember_token))
	else
		visit signin_path
		fill_in  "邮件"	,with: user.email.upcase
		fill_in  "密码",with:user.password
		click_button "登录"
	end
end