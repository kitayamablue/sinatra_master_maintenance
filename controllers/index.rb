# coding:utf-8

get '/' do
	@title = '近畿IDC HVシステム　メニュー'
	# erb :index , :layout => false
	haml :index
end

