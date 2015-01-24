class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :async,:trackable, :validatable,
         :confirmable

  has_one :customer, dependent: :destroy
  has_one :provider, dependent: :destroy
  has_and_belongs_to_many :roles

  # ROLES = %w[fornecedor noiva(o)]


  def set_completed
    self.is_completed = true
    self.save
  end

  def is_customer?
    unless self.roles.empty?
      return role_id == 1
    end
  end

  def is_provider?
    unless self.roles.empty?
      return role_id == 2
    end
  end

  def role_id
    self.roles.first.id
  end

  def is_customer_completed?
    if self
      self.is_completed && self.is_customer?
    end
  end

   def is_provider_completed?
    if self
      self.is_completed && self.is_provider?
    end
  end



end
