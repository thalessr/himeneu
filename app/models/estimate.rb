class Estimate < ActiveRecord::Base

  belongs_to :provider
  belongs_to :customer

  validates_presence_of :provider
  validates_presence_of :customer
end
