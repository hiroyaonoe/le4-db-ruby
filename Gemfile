source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.3", ">= 7.0.3.1"
gem "puma", "~> 5.0"
gem "turbo-rails"
gem "webpacker"
gem "jbuilder"
gem "bootsnap", require: false
gem "sassc-rails"
gem "importmap-rails"

group :development, :test do
  gem "sqlite3"
  gem "byebug"
end

group :development do
  gem "web-console"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
