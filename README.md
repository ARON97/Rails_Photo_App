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
Check for uncommited status, git status, git add -A, git commit -m "Make app production ready" and git push, to push our changes to github repository and git push heroku master

SETUP AUTHENTICATION SYSTEM
Add gem 'devise', gem 'twitter-bootstrap-rails', gem 'devise-bootstrap-views'. In rails 5 also add gem 'jquery-rails'
Run bundle install --without production
SET UP RAILS DEVISE
rails generate devise:install
rails generate devise User, creates User
NOTE: After installing devise restart rails server

UPDATE MIGRATION FILE TO ALLOW FOR THE CONFIRMABLE ATTRIBUTES INORDER FOR EMAIL AUTHENTICATION
To add confirmable to existing user model after the application has already been used for sometime access github.com/platformatec/devise/wiki/How-To:-confirmable-to-Users
We going to do it in the beginning
Pull up the migration file. db/migrate/20180507220750_devise_create_users.rb, uncomment ## Confirmable.
Pull up model/user.rb and add :confirmable,
rails db:migrate, Run migration
Go to controllers/application_controller.rb and add before_action: authenticate_user!, to access the application you need to be a logged in user
To skip login to access the index page, go to welcome_controller.rb and add code stated there with comment

ADDING STYLING
rails generate bootstrap:install static
rails g bootstrap:layout application, enter in Y
rails g devise:views:locale en
rails g devise:views:bootstrap_templates
In rails 5, remove 5 favicon link tags from application.html.erb, this was in line 14-30 and //= require jquery under //= require rails-ujs in app/assets/javascript/application.js
In app/assets/stylesheets/application.css add *= require devise_bootstrap_views