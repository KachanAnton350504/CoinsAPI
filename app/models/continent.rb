class Continent < ActiveRecord::Base
  validates :name, presence: true
  has_many :countries 
  has_many :coin_sets, through: :countries
end
