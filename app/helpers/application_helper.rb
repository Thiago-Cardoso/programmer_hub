module ApplicationHelper
  def liked?(user, post) #se o usuario que esta logado deu like no post
    user.likes.find_by(post_id: post.id) #se encontrar o like true
  end
end
