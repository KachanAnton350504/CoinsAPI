class Continent < ActiveRecord::Base
  validates :name, presence: true
  has_many :countries
end
