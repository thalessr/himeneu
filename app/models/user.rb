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
  @is_provider = nil
  @is_customer = nil
  @is_completed = nil

  def set_completed
    self.update_attribute(:is_completed, true)
  end

  def is_customer?
    @is_customer = get_redis_value("is_customer_#{self.id}")
    if @is_customer.nil?
      set_redis_key("is_customer_#{self.id}", self.roles.exists?(id: 1).to_json)
    end
    return @is_customer
  end

  def is_provider?
    @is_provider = get_redis_value("is_provider_#{self.id}")
    if @is_provider.nil?
       set_redis_key("is_provider_#{self.id}" ,self.roles.exists?(id: 2).to_json)
    end
    return @is_provider
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

  def is_completed?
     if @is_completed.nil?
      @is_completed ||= self.is_completed
    end
    return @is_completed
  end

  def is_customer_completed?
    if self
      is_completed? && self.is_customer?
    end
  end

  def is_provider_completed?
    if self
      is_completed? && self.is_provider?
    end
  end

  private
  def set_redis_key(key, value)
    $redis.set(key, value)
    $redis.expire(key, 1.hour.to_i)
  end

  def get_redis_value(key)
    JSON.load  $redis.get(key)
  end

end
