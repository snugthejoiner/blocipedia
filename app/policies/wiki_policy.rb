class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope
  
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'          #admin sees everything
        wikis = scope.all
      elsif user.role == 'premium'     #premium users see public wikis & private wikis they created
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user #|| wiki.users.include?(user)
            wikis << wiki
          end
        end
      else                              #standard users
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? #|| wiki.users.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end

end