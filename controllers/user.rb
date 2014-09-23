# coding:utf-8

before '/*' do
end

class User < ActiveRecord::Base
	self.table_name = "m_user"
	self.per_page = 20
end

get '/users' do
	@title = '作業者一覧'
	@users = User.paginate(:page => flash[:page] ? flash[:page] : params[:page], :order => 'UserId')
	session[:last_page] = @users.current_page
	haml :user
end

get '/sample.css' do
	content_type 'text/css', :charset => 'utf-8'
	scss :sample
end

