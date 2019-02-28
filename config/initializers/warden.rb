Warden::Strategies.add(:token, Authentication::Strategies::Token)

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.failure_app = UnauthorizedController
  manager.default_strategies :token
end

class Warden::SessionSerializer
  def serialize(record)
    [Hash, record['email']]
    # [record.class.name, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    klass.find_by(id: id)
  end
end
