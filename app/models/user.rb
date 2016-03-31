class User < ActiveRecord::Base
 # acts_as_token_authenticatable
  devise :database_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable
  has_and_belongs_to_many :coins
  
# attr_accessible :name, :email, :authentication_token


  before_save :ensure_authentication_token

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
