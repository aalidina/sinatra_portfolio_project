require 'pry'
class UserController < ApplicationController


  get '/login' do
    if logged_in?
      redirect to '/currencies/new'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/new'
    else
      redirect to '/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect to '/new'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
=begin
we still access the attribute of password  because of the has_secure_password
=end
    @user = User.new(username: params[:username], password: params[:password], email:  params[:email])

    if @user.save && @user.username != "" && @user.email != ""
      session[:id] = @user.id
      redirect to '/new'
    else
      session[:error] = "Your details were not saved to our database. Please try again."
      redirect to '/signup'
    end

  end



  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    end
  end

end
