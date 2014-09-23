# coding:utf-8

before '/*' do
end

class Warning < ActiveRecord::Base
	self.table_name = "m_warning"
	self.per_page = 20
end

get '/warnings' do
	@title = '警告メッセージ一覧'
	@warnings = Warning.paginate(:page => flash[:page] ? flash[:page] : params[:page], :order => 'Warning')
	session[:last_page] = @warnings.current_page
	haml :warning
end

get '/sample.css' do
	content_type 'text/css', :charset => 'utf-8'
	scss :sample
end

