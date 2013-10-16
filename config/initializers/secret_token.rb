# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Sndcrd::Application.config.secret_key_base = 'c84afe249c6ba39cc395969c17984f21171c3706d83eeda19b0d24f7b16c9aa2530e8047fb7c0c7587441d86759e6c171c833bdfbae1121ab280127f26195e77'

SECRETS = YAML.load_file(File.join(Rails.root, 'config', 'secrets.yml'))
