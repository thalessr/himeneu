#Common methods for both providers and customers
require 'active_support/concern'
module Extra

  def self.included(including_class)
    including_class.extend ClassMethods
  end

  module Methods

    def full_name
      "#{first_name} #{last_name}"
    end

    def slug_options
      [
        :first_name,
        [:first_name, :last_name],
        [:first_name, :age, :last_name]
      ]
    end

    def delete
      user.update_attribute(:is_deleted, true)
    end

    def recover
      user.update_attribute(:is_deleted, false)
    end

    def is_deleted?
      user.is_deleted
    end

  end

  #when a method use active record
  module Selection
    extend ActiveSupport::Concern

    def self.extended(base)
      base.class_eval do
        has_many :recommendations, dependent: :destroy
        has_many :estimates, dependent: :destroy
      end
    end

    def recent(number)
      if number
        limit(number).reverse_order
      else
        none
      end
    end

    def not_deleted
      joins(:user).where('users.is_deleted = ? OR users.is_deleted = ?', false, nil )
    end

    def deleted
      joins(:user).where('users.is_deleted = ?', true )
    end

    def first_last_name_search(name)
      where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?", name, name ) unless name.blank?
    end

    def city_name_search(association_name, city)
      distinct.joins(association_name).where("LOWER(addresses.city) LIKE ? ", city) unless city.blank?
    end

  end

end
