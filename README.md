# Heroku OAuth Example

Example Sinatra application using OmniAuth to OAuth against the Heroku API.

```
$ cat > .env <<EOF
HEROKU_KEY=...
HEROKU_SECRET=...
COOKIE_SECRET=...
EOF
$ bundle install
$ foreman start
$ open http://127.0.0.1:5000
```
