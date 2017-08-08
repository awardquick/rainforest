class User < ApplicationRecord

  has_secure_password
  has_many :products
  has_many :purchased_products
end
