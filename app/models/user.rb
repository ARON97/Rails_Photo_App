class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  # Associations
  # The user will only have to pay once to use the website
  has_one :payment
  # When we sign up a user it is going to be handled by registration form. In that form not
  # only are we goig to hit the users table. We also going to hit the payments table.
  # The user accepts nested attributes for payment through the form submission also
  accepts_nested_attributes_for :payment
  has_many :images
end
