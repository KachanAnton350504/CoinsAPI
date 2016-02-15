class Country < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :continent
  has_many :coin_sets
end
