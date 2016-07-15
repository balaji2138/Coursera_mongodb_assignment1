require 'mongo'

class Racer

  attr_accessor :id, :number, :first_name, :last_name, :gender, :group, :secs 

  def initialize(params={})
    @id = params[:_id].nil? ? params[:id] : params[:_id].to_s
    @number = params[:number].to_i
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @gender = params[:gender]
    @group = params[:group]
    @secs = params[:secs].to_i
  end

  def self.mongo_client
    # Mongo::Client.new('mongodb://localhost:27017')
    Mongoid::Clients.default
  end

  def self.collection
    self.mongo_client[:racers]
  end

  def self.all(prototype={}, sort={number: 1}, skip=0, limit=nil)
    if limit.nil?
      result=collection.
                find(prototype).
                sort(sort).
                skip(skip)
    else
      result=collection.
                find(prototype).
                sort(sort).
                limit(limit).
                skip(skip)
    end
  end
  def self.find(id)
    result = collection.find(:_id => BSON::ObjectId(id)).first
    return result.nil? ? nil : Racer.new(result)
  end

  def save
    params={}
    # params[:_id] = BSON::ObjectId(@id)
    params[:number] = @number
    params[:first_name] = @first_name
    params[:last_name] = @last_name
    params[:gender] = @gender
    params[:group] = @group
    params[:secs] = @secs
    result = self.class.collection.insert_one(params)
    @id = result.inserted_id
  end

  def update(params)

    @number = params[:number].to_i
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @gender = params[:gender]
    @group = params[:group]
    @secs = params[:secs].to_i
    # racer1=self.find(@id)

    self.class.collection.find(_id:@id).update_one(:$set => params)
  end

  def destroy
    self.class.collection.find(_id:@id).delete_one
  end

end