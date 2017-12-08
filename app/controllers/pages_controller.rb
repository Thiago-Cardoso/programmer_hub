class PagesController < ApplicationController
	skip_before_filter :authenticate_user! #faz com que o devise não obrigue a pagina(nao precisa login)
  def home
  end
end
