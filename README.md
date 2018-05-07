CREATE NEW APP
rails new photo-app

SETUP A HOMEPAGE
rails generate controller welcome index
Change get 'welcome/index' to root 'welcome#index' in routes

GET APP READY FOR HEROKU DEPLOYMENT
git init, initialize git reposititory
git add -A
git commit -m "Initial commit with home page"
Move gem 'sqlite3' in Gemfile to group:development, :test do
Create group :production do and modify it. When using rails 4 add gem rails_12factor
Run bundle install --without production, updates Gemfile.lock
Go to github and create a repository for the photo-app. This can be found in 052 Setup Github Repository lecturer
After created run git remote add origin git@github.com:...../photo-app.git and git push -u origin master, this pushes all our code to our repository
CREATE HEROKU APP AND DEPLOY IT
heroku create
heroku rename aron-photo-app
Check for uncommited status, git status