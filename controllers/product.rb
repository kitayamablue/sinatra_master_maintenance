# coding:utf-8

#クラス変数(庫内統一品番)
@@sku = '%'

before '/products*' do
end

# 商品マスタ
class Product < ActiveRecord::Base
	self.table_name = "m_syouhin"
	self.per_page = 10
end

get '/products' do
	@title = '商品一覧'

	@products = Product.paginate(:select => "m_syouhin.SKU, m_syouhin.Hinmei, m_syouhin.Height, m_syouhin.Width, m_syouhin.Depth, m_syouhin.Weight, 
											 m_category.Category, m_warning.WarningMsg, m_syouhin.PicFlg",
								:joins => "LEFT JOIN m_category ON m_syouhin.CategoryNo = m_category.CategoryNo
							               LEFT JOIN m_warning on m_syouhin.Warning = m_warning.Warning",
				            	# :conditions => ["m_syouhin.SKU LIKE ?", "#{@@sku}%"],
			            		:conditions => ["m_syouhin.SKU LIKE ? or m_syouhin.Hinmei LIKE ? ", "#{@@sku}%","%#{@@sku}%"],
							 	:page => flash[:page] ? flash[:page] : params[:page],
							 	:order => 'm_syouhin.SKU',
							 	# :limit => 15
								)
	
	session[:last_page] = @products.current_page
	haml :product
end

post '/new' do
	@@sku = params[:sku]
	redirect '/products'
end

get '/sample.css' do
	content_type 'text/css', :charset => 'utf-8'
	scss :sample
end
