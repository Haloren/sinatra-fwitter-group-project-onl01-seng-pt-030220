class UsersController < ApplicationController

    get '/signup' do

        if !logged_in?
            erb :'users/create_user'
        else
            redirect to '/tweets'
        end

    end

    post '/signup' do
        @user = User.new(params)

        if !@user.save
            erb :'users/create_user'
        else
            session[:user_id] = @user.id
            redirect to '/tweets'
        end

    end

    get '/login' do

        if !logged_in?
            erb :'users/login'
        else
            redirect to '/tweets'
        end

    end

    post '/login' do
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            session[:id] = user.id
            redirect '/guides'
        else
            erb :'users/login'
        end

    end

    get '/logout' do
        session.destroy
        redirect '/'
    end

end
