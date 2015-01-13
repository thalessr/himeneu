class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :async,:trackable, :validatable,
         :confirmable

  has_many :customers, dependent: :destroy
  has_many :providers, dependent: :destroy
  has_and_belongs_to_many :roles

  ROLES = %w[fornecedor noiva(o)]


  def is_customer?
   unless self.roles.empty?
      if self.roles.first.id == 1
        return true  #check seeds, it can be improved
      else
        return false
      end
    end
  end

  def set_completed
    self.is_completed = true
    self.save
  end

  def is_provider?
    unless self.roles.empty?
      if self.roles.first.id == 2
        return true  #check seeds, it can be improved
      else
        return false
      end
    end
  end

end
