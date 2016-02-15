class Coin < ActiveRecord::Base
  validates :nominal, :currency, presence: true
  has_and_belongs_to_many :users
  belongs_to :coin_set
end
