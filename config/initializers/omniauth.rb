Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_app_id'], ENV['facebook_secret_token'],
           :scope => 'email,user_birthday', :display => 'popup'
end