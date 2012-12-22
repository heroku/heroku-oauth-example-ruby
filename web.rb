$stdout.sync = $stderr.sync = true

require "cgi"
require "sinatra"
require "omniauth"
require "omniauth-heroku"
require "heroku-api"

use Rack::Session::Cookie, :secret => ENV["COOKIE_SECRET"]
use OmniAuth::Builder do
  provider :heroku, ENV["HEROKU_KEY"], ENV["HEROKU_SECRET"]
end

get "/" do
  <<-HTML
    <a href='/auth/heroku'>Sign in with Heroku</a>
  HTML
end

get "/auth/heroku/callback" do
  auth =
  session[:heroku_oauth_token] =  request.env["omniauth.auth"]["credentials"]["token"]
  redirect "/user"
end

get "/user" do
  if !session[:heroku_oauth_token]
    redirect("/")
  else
    user_email = Heroku::API.new(:api_key => session[:heroku_oauth_token]).get_user.body["email"]
    <<-HTML
      Hi #{CGI.escapeHTML(user_email)}
    HTML
  end
end
