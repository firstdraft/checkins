# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.3"

gem "aasm"
gem "acts_as_commentable_with_threading"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap"
gem "chronic"
gem "devise"
gem "ims-lti", git: "git://github.com/wjordan/ims-lti.git", branch: "oauth_051"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "kramdown"
gem "kramdown-parser-gfm"
gem "paper_trail"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 5.6"
gem "pundit"
gem "rack-canonical-host"
gem "rails", "~> 5.2.0.rc1"
gem "rails_12factor"
gem "rouge"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "awesome_print"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "pry-rails"
  gem "rspec-rails", "~> 3.7"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
end

group :development do
  gem "annotate"
  gem "better_errors", github: "charliesome/better_errors"
  gem "binding_of_caller"
  gem "bullet"
  gem "draft_generators", github: "firstdraft/draft_generators"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "meta_request"
  gem "rails-erd"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "skylight"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
