OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ' 635038181287-vpd44rutj5osumlnsra7k0t0iduit5p5.apps.googleusercontent.com ', ' 4GUDXBbdElAAydALuJJpOR7I ', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end

