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

  get '/robots/:name' do |name|
    @robots = robot_manager.find(name)
    erb :show
  end

  get '/robots/:name/edit' do |name|
    @robots = robot_manager.find(name)
    erb :edit
  end

  put '/robots/:name' do |name|
    robot_manager.update(name, params[:robot])
    redirect "/robots/#{name}"
  end

  delete '/robots/:name' do |id|
    robot_manager.delete(name)
    redirect "/robots"
  end

  def robot_manager
    database = YAML::Store.new('db/robot_manager')
    @robot_manager ||= RobotManager.new(database)
  end
end
