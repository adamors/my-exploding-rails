ROM::Rails::Railtie.configure do |config|
  database_env_var = Rails.env.test? ? 'DATBASE_URL_TEST' : 'DATABASE_URL'
  config.gateways[:default] = [:sql, ENV.fetch(database_env_var)]
end
