require 'models/robot_manager'

class RobotManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do #dashboad is landing page for user
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_manager.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    robot_manager.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:name' do |id|
    @robots = robot_manager.find(id)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robots = robot_manager.find(id)
    erb :edit
  end

  put '/robots/:id' do |id|
    robot_manager.update(id, params[:robot])
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    robot_manager.delete(name)
    redirect "/robots"
  end

  def robot_manager
    database = YAML::Store.new('db/robot_manager')
    @robot_manager ||= RobotManager.new(database)
  end
end
