require 'mongo'

class Racer
  def self.mongo_client
    # Mongo::Client.new('mongodb://localhost:27017')
    Mongoid::Clients.default
  end

  def self.collection
    self.mongo_client[:racers]
  end

end