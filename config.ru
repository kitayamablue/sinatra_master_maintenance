Encoding.default_external = 'utf-8'

require 'sinatra'
require 'activerecord-sqlserver-adapter'
require 'sinatra/reloader'
require 'tiny_tds'
require 'haml'
require 'will_paginate'
require 'will_paginate/active_record'
require 'rack-flash'
require 'sass'

require File.dirname(__FILE__)+'/bootstrap'
Bootstrap.init :helpers, :controllers

set :haml, :escape_html => true

run Sinatra::Application