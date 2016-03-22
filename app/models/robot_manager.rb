require 'yaml/store'
require_relative 'robot'

class RobotManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << {"name" => database['total'], "title" => robot[:title], "description" => robot[:description]}
    end
  end

  def update(name, robot)
    database.transaction do
      target = database['robots'].find { |data| data["name"] == name}
      target["title"] = robot[:title]
      target["description"] = robot[:description]
    end
  end

  def delete(name)
    database.transaction do
      database['robots'].delete_if { |robot| robot["name"] == name}
    end
  end

  def raw_robots
    database.transaction do #database is the YAML file
      database['robots'] || []
    end
  end

  def all
    raw_robots.map do |data|
      Robot.new(data)
    end
  end

  def raw_robot(name)
    raw_robots.find do |robot|
      robot["name"] == name
    end
  end

  def find(id)
    Robot.new(raw_robot(name))
  end

end
