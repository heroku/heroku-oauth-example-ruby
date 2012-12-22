# Heroku OAuth Example

Example Sinatra application using OAuth against the Heroku API.

## Usage

First, acquire a `localhost:5000` OAuth key/secret pair from the API team. Then:

```
$ cat > .env <<EOF
HEROKU_ID=...
HEROKU_SECRET=...
COOKIE_SECRET=...
EOF
$ bundle install
$ foreman start
$ open http://127.0.0.1:5000
```
