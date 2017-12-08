class UsersController < ApplicationController

  #load_and_authorize_resource
  before_action :set_user, only: [:show, :following, :followers]

  def show #mostra o profile do usuario
    @posts = @user.posts #pega a lista de posts
    @following = @user.following_users.limit(5) #pega o numero de pessoas que segue
    @followers = @user.followers_by_type('User').limit(5) #pega as pessoas qu seguem
  end

  def followers
  	 @following = @user.following_users
  end

  def followings
  	@followers = @user.followers_by_type('User')
  end

  def search
  	@user = current_user #pega o usuario atual
    @query = User.ransack(params[:q]) #pega a consulta passada para a pesquisa
    @users = @query.result(distinct: true) #usuarios
  end
   private
 
    def set_user
      @user = User.find(params[:id]) #pega os parametros usuario da url
    end
end
