class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :async,:trackable, :validatable,
         :confirmable

  has_one :customer, dependent: :destroy
  has_one :provider, dependent: :destroy
  has_and_belongs_to_many :roles
  validates_presence_of :roles

  # ROLES = %w[fornecedor noiva(o)]


  def set_completed
    self.is_completed = true
    self.save
  end

  def is_customer?
    return self.roles.exists?(id: 1)
  end

  def is_provider?
    return self.roles.exists?(id: 2)
  end

  def role_id
    self.roles.first.id
  end

  def customer_id(user_id)
    customer = Customer.select(:id).find_by(user_id: user_id)
    customer.id
  end

  def provider_id(user_id)
    provider = Provider.select(:id).find_by(user_id: user_id)
    provider.id
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
