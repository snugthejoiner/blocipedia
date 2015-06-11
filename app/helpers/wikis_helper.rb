module WikisHelper
  def collaboration(wiki,user)
    c = Collaborator.where(wiki_id: wiki, user_id: user)
    i = params.fetch(:id)
  end
end
