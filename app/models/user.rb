class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings
  
  # before_save :enforece_lowercase_username

  # private

  # def enforece_lowercase_username
  #   self.username = self.username.downcase
  # end
end
