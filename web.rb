$stdout.sync = $stderr.sync = true

require "cgi"
require "excon"
require "multi_json"
require "sinatra"
require "omniauth"
require "omniauth-heroku"

use Rack::Session::Cookie, :secret => ENV["COOKIE_SECRET"]
use OmniAuth::Builder do
  provider :heroku, ENV["HEROKU_ID"], ENV["HEROKU_SECRET"]
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
    api = Excon.new(ENV["HEROKU_API_URL"] || "https://api.heroku.com",
      headers: { "Authorization" => "Bearer #{session[:heroku_oauth_token]}" })
    res = api.get(path: "/account", expects: 200)
    user_email = MultiJson.decode(res.body)["email"]

    <<-HTML
      Hi #{CGI.escapeHTML(user_email)}
    HTML
  end
end
