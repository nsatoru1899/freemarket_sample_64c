# Elastic IPの修正が必要
server '<用意したElastic IP>', user: 'ec2-user', roles: %w{app db web}

set :rails_env, "production"
set :unicorn_rack_env, "production"