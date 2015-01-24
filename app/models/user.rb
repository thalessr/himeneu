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


  def set_completed
    self.is_completed = true
    self.save
  end

  def is_customer?
    unless self.roles.empty?
      return self.roles.first.id == 1
    end
  end

  def is_provider?
    unless self.roles.empty?
      return self.roles.first.id == 2
    end
  end

  def role_id
    if self.is_customer?
      return self.customers.first.id
    else
      return self.providers.first.id
    end
  end

  def is_customer_completed?
    self.is_completed && self.is_customer?
  end

   def is_provider_completed?
    self.is_completed && self.is_provider?
  end

end
