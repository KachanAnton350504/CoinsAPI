class User < ActiveRecord::Base
  acts_as_token_authenticatable
  devise :database_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable
 has_and_belongs_to_many :coins
end
