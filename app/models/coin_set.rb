class CoinSet < ActiveRecord::Base
  validates :years, presence: true
  belongs_to :country
  has_many :coins
end
