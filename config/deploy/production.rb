# Elastic IPの修正が必要
server '54.199.158.8', user: 'ec2-user', roles: %w[app db web]

set :rails_env, "production"
set :unicorn_rack_env, "production"
