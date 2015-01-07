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
  	return self.role == "noiva(o)"
  end

  def set_completed
    self.is_completed = true
    self.save
  end

end
