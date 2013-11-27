# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
OpalApp::Application.config.secret_key_base = '65dee096de9f0483e2f305b0affb1868402dbca8e81d8304b03dcb28983c30fb1101291dd596cdf3ad40e78b650b24f6c2bf2ca1b638bf364cb63b40cbe68c1f'
