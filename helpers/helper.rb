=begin
 起動時に一回だけ読み込まれる
　必要なライブラリをロードするコードはここに書く
　（必要になったら）データベースへの接続などをここで行うと良い。
　app_rootという関数が定義されている（重要）
　これにより、開発サーバー・サブドメインでの運用・サブディレクトリでの運用でも内部のURLがズレない
　jsからサーバーのAPIにアクセスする時、hamlでcssを読み込む時などに便利
=end

# I18nエラー回避
I18n.enforce_available_locales = false

# データベースの設定ファイルを読む
helpers do
	ActiveRecord::Base.configurations = YAML.load_file(Conf.file)
	ActiveRecord::Base.establish_connection(:development)
	use ActiveRecord::ConnectionAdapters::ConnectionManagement
  # def app_root
  #   "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{env['SCRIPT_NAME']}"
  # end
end

#WillPaginate
class PaginateRenderer < WillPaginate::Sinatra::LinkRenderer
	protected
 
	def page_number(page)
        unless page == current_page
          tag(:li, link(page, page, :rel => rel_value(page)))
        else
          tag(:li, link(page, '#'), :class => 'active')
        end
  	end
 
	def next_page
		num = @collection.current_page < total_pages && @collection.current_page + 1
		previous_or_next_page(num, @options[:next_label], 'next')
	end

	def previous_page
		num = @collection.current_page > 1 && @collection.current_page - 1
		previous_or_next_page(num, @options[:previous_label], 'previous')
	end
 
	def previous_or_next_page(page, text, classname)
		if page
		  tag(:li, link(text, page), :class => classname)
		else
		  tag(:li, link(text, '#'), :class => classname + ' disabled')
		end
	end

	def html_container(html)
		tag(:ul, html, container_attributes)
	end
end

# テーブルのヘッダの色(scss→css)
get '/sample.css' do
	# content_type 'text/css', :charset => 'utf-8'
	scss :sample
end

# Sessionの設定
enable :sessions
set :session_secret, 'xxx'
use Rack::Flash

set :environment, :production
