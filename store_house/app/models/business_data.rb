class BusinessData < ActiveRecord::Base

  # Associations
  has_many :addresses, :as => :addressable

  # Attributes
  attr_accessible :name, :company, :tax_number, :email, :telephone, :mobile

  # Validations
  validates :name, :tax_number, :presence => true
  validates :tax_number, :length => { :maximum => 9 }
end
