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
      update_attribute(:is_deleted, true)
    end

    def recover
      update_attribute(:is_deleted, false)
    end

    def is_deleted?
      is_deleted
    end

  end

  #when a method use active record
  module Selection
    extend ActiveSupport::Concern

    def self.extended(base)
      base.class_eval do
        has_many :recommendations, dependent: :destroy
        has_many :interests, dependent: :destroy
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
      where(is_deleted: [false, nil] )
    end

    def deleted
      where(is_deleted: true )
    end

    def first_last_name_search(name)
      where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?", name, name ) unless name.blank?
    end

    def city_name_search(association_name, city)
      distinct.joins(association_name).where("LOWER(addresses.city) LIKE ? ", city) unless city.blank?
    end

  end

end
