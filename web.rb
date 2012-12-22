require "sinatra"
require "omniauth"
require "omniauth-heroku"

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :heroku, ENV["HEROKU_KEY"], ENV["HEROKU_SECRET"]
end

get "/" do
  <<-HTML
    <a href='/auth/heroku'>Sign in with Heroku</a>
  HTML
end

get "/auth/heroku/callback" do
  auth = request.env["omniauth.auth"]
  $stdout.puts(auth.inspect)
  $stdout.flush
  "<h3>thanks</h3>"
end
