# encoding: UTF-8
class SessionsController < ApplicationController
  # GET /signin
  def new
  end

  # POST /signin
  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, :notice => "Bem vindo, #{@user.username}"
    else
      flash[:alert] = 'Usuário e/ou senha não encontrado'
      render :new
    end
  end

  # GET /signup
  def signup_new
  end

  # POST /signup
  def signup_create
    @user = User.new(:username => params[:username], :password => params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, :notice => "Bem vindo, #{@user.username}"
    else
      flash[:alert] = 'Por favor, verifique todos os campos.'
      render :signup_new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/signin'
  end
end
