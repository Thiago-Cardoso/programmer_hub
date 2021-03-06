class FollowsController < ApplicationController

	load_and_authorize_resource

	 before_action :set_user

  def create
  	respond_to do |format|
      if current_user.follow(@user) #passa o usuario seguido
        format.json { render @user, status: :created }
        format.html { redirect_to :back, notice: 'User followed with success.' } #sucesso
      else
        format.json { render json: nil, status: :unprocessable_entity }
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
  	respond_to do |format|
      if current_user.stop_following(@user) #destroi, passando o current_user
        format.json { head :no_content }
        format.html { redirect_to :back, notice: 'User unfollowed with success.'}
      else
        format.json { render json: nil, status: :unprocessable_entity }
        format.html { redirect_to :back }        
      end
    end
  end

    private

    def set_user
      @user = User.find(params[:user_id]) #pega o usuario seguido
    end

end
