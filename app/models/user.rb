class User < ActiveRecord::Base
  default_scope {order(username: :asc)}
  has_many :wikis
  has_many :collaborators
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def upgrade
    self.role = 'premium'
    self.save
  end


end