class PostsController < ApplicationController

  load_and_authorize_resource
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
   # flash[:notice] = "sucesso";
    @user = current_user    #pega o usuario atual
     @post = Post.new
    posts = @user.posts.map {|post| post}
    @user.all_following.each { |user| user.posts.each{|post| posts << post } }
    @posts = (posts.sort_by! { |post| post.created_at }).reverse
    @posts = @posts.paginate(:page => (params[:page] || 1), :per_page => 10)

    respond_to do |format|
      format.html
      format.js
    end

  end

   def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.json { render json: @post, status: :created }
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.js   { render :file => "/app/views/posts/show.js.erb" }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.html { redirect_to posts_path }
      end
    end
  end

  def show
    @comment = Comment.new #visualiza o post
    @comments = @post.comments #pega todos os comentarios
  end

  def destroy
    @post.destroy #deleta o post
 
    respond_to do |format|
      format.json { head :no_content } #vazio deu certo
      format.html { redirect_to posts_path, notice: 'Post was successfully destroyed.' } #sucesso
    end
  end

  def edit
    @user = current_user    #pega o usuario atual
    posts = current_user.posts.map {|post| post} #pega todos os posts do usuario (transforma num array de posts)
    current_user.all_following.each { |user| user.posts.each{|post| posts << post } } #pega todos os usuarios que segue
    @posts = posts.sort_by &:created_at #ordena por data de criacao mostrando o ultimo post

  end

  def update

    respond_to do |format|  #se salvar o post rendeniza
       if @post.update(post_params)
        format.json { render json: @post, status: :created }
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' } #sucesso
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.html { redirect_to posts_path }
      end
    end
  end

  private
 
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
       params.require(:post).permit(:body).merge(user: current_user)
  end

end
