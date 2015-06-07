class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :visible_to, -> (user) {user.role == 'premium' ? all : where(private: false) }

  def private?
    private == true
  end
  
end
