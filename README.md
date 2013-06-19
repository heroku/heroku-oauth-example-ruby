# Heroku OAuth Example: Ruby

Example Ruby/Sinatra application using OAuth to authorize users with the Heroku API.

## Usage

First, create an OAuth client on Heroku. The easiest way to do this is from your account page on [Heroku Dashboard](https://dashboard.heroku.com/account). When prompted for a callback URL, use `http://localhost:5000/auth/heroku/callback`.

The [OAuth developer documentation](https://devcenter.heroku.com/articles/oauth) has additional resources.

When you create the OAuth client, you get get an id and secret. Register these in your apps environment and start the app:

```
$ cat > .env <<EOF
HEROKU_OAUTH_ID=...
HEROKU_OAUTH_SECRET=...
COOKIE_SECRET=change_me
EOF
$ bundle install
$ foreman start
$ open http://127.0.0.1:5000
```
