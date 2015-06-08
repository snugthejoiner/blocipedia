class Wiki < ActiveRecord::Base
  belongs_to :user

  def private?
    self.private == true
  end

  def public?
    self.private == false
  end
  
end
