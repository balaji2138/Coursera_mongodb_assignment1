require 'mongo'

class Racer
  def self.mongo_client
    # Mongo::Client.new('mongodb://localhost:27017')
    Mongoid::Clients.default
  end

  def self.collection
    self.mongo_client[:racers]
  end

  def self.all(prototype={}, sort={number: 1}, skip=0, limit=nil)
    if limit.nil?
      result=collection.find(prototype).sort(sort).skip(skip)
    else
      result=collection.find(prototype).sort(sort).limit(limit).skip(skip)
    end
  end

end