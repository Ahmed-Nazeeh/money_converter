class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable
    validates :name, length: { minimum: 2,  maximum: 100 }, format: { with: /\A[a-zA-Z\s]+\z/ }     
end
