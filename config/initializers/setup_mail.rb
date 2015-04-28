ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "amurabuzz.dev",
  :user_name            => "amurabuzz@gmail.com",
  :password             => "amurabuzz1234",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "amurabuzz.dev"