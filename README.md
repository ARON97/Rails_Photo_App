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
Pull up models/user.rb and add :confirmable,
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

EMAIL IN DEVELOPMENT
You do not need to send the confirmation email. You can grab the email link that is generated from the server itself. It will show up in the server but in production you need the actual email to be sent

EMAIL IN PRODUCTION(Heroku)
We going to use send grid, it is a transactional email provider that comes with your heroku account. All you need is a verified heroku account. To work with things like production emails, storage etc. you will need things like credit cards with the service providers. Alternatively you can skip the production steps and perform the development steps which don't require credit cards. It is not going to charge you anything
With the starter tier of send grid you can get up to 400 emails per day.
When we do our configurations we are going to set the development email functionality to TEST and in production it will :SMTP

heroku addons:create sendgrid:starter, adds sendgrid to heroku
ADD A CREDIT CARD TO HEROKU
heroku.com and sign in, account icon, account settings, go to the billing tab and add a credit card. This is just for account verification purposes
heroku addons:create sendgrid:starter, adds sendgrid to heroku again.
Go to your heroku account again and go to the photo app. Click on the sendgrid. Go to settings, API keys- there is going to be an option where you can create an API key. Create the API key and save it, make sure you save it because it is only displayed once.
We now going to set it up in the heroku app and then locally
heroku config:set SENDGRID_USERNAME=apikey
heroku config:set SENDGRID_USERNAME=(paste in the API key)
SETTING UP IN THE LOCAL ENVIRONMENT
Go to show hidden files and then click on .profile file
Set the SENDGRIND_USERNAME=apikey and SENDGRID_PASSWORD=(api key)
SET UP IN APPLICATION
Open config/environment.rb. Add ActionMailer::Base.smtp_settings = {
	:address => 'smtp.sendgrid.net',
	:post => '587',
	:authentication => :plain,
	:user_name => ENV['SENDGRID_USERNAME'],
	:password => ENV['SENDGRIND_PASSWORD'],
	:domain => 'heroku.com',
	:enable_starttls_auto => true
}
Update config/environments/development.rb Under config.eager_load = false add
config.action_mailer.delivery_method = :test
config.action_mailer.default_url_options = { :host => '(link to current local development environment. e.g. http://ruby-on-rails-123170.nitrousapp.com:3000/'}
Go to config/environments/production.rb and under config.eager_load = test add
config.action_mailer.delivery_method = :smtp
config.action_mailer.default_url_options = { :host => '(link to current production environment. e.g. aron-photo-app.herokuapp.com', :protocol => 'https'}

Email confirmation link: http://https/users/confirmation?confirmation_token=gYcTabQeCMupjH5K-qNs&amp;locale=en">Confirm my account
First email tried was: Joe@example.com
In production run heroku logs and look for the confirmation link

UPDATE NAVIGATION
In views/layouts/application.html.erb
Create app/assets/stylesheets/custom.css.scss

CHANGING: please-change-me-at-config-initializers-devise@example.com
Go to config/initializers/devise.rb on line 21

BUILDING HOMEPAGE
In views/welcome/index.html.erb
Change the column to 12 so that the Jumbotron is aligned in views/layouts/application.html.erb on line 67