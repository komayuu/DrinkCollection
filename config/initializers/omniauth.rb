Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
           {
             scope: "email,profile",
             prompt: "select_account"
           }
end

OmniAuth.config.path_prefix = "/auth"
OmniAuth.config.allowed_request_methods = %i[get post]
