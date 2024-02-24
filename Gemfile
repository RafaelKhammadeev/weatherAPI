source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.7", ">= 6.1.7.6"

gem "bootsnap", ">= 1.4.4", require: false
gem "grape"
gem "httparty"
gem "jbuilder", "~> 2.7"
gem "pg"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "interactor"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "pry"
  gem "rubocop", require: false
  gem "rubocop-i18n", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rake", require: false
  gem "rubocop-thread_safety", require: false
  gem "rspec-rails"
  gem "webmock"
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
