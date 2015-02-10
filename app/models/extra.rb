#Common methods for both providers and customers
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
  end

  #when a method use active record
  module Selection
    def recent(number)
      if number
        limit(number).reverse_order
      else
        none
      end
    end
  end

end