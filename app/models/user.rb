class User < ActiveRecord::Base
  include CacheRedis::Utils
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  if Rails.env.production?
    devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :async,:trackable, :validatable,
      :confirmable
  else
    devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :validatable
  end

  has_one :customer, dependent: :destroy
  has_one :provider, dependent: :destroy
  has_and_belongs_to_many :roles
  # validates_presence_of :roles

  @is_provider = nil
  @is_customer = nil

  def set_completed(role)
    update_attributes(is_completed: true, role_ids: [role])
  end

  def is_customer?
    if Rails.env.production?
      @is_customer = get_redis_value("is_customer_#{self.id}")
      if @is_customer.nil?
        set_redis_key("is_customer_#{self.id}", self.roles.exists?(id: 1).to_json)
        @is_customer = get_redis_value("is_customer_#{self.id}")
      end
      return @is_customer
    else
      self.roles.exists?(id: 1)
    end
  end

  def is_provider?
    if Rails.env.production?
      @is_provider = get_redis_value("is_provider_#{self.id}")
      if @is_provider.nil?
        set_redis_key("is_provider_#{self.id}" ,self.roles.exists?(id: 2).to_json)
        @is_provider = get_redis_value("is_provider_#{self.id}")
      end
      return @is_provider
    else
      self.roles.exists?(id: 2)
    end
  end

  def is_completed?
    if self
      self.is_completed
    end
  end

  def is_deleted?
    self.is_deleted if self
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

  def address
    if is_customer?
      self.customer.city
    else
      self.provider.addresses.map(&city)
    end

  end

end
