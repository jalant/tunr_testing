class Artist < ActiveRecord::Base
  attr_accessible :name, :url

  validates_presence_of :name
  validates_presence_of :url

  has_many :albums, through: :songs
  has_many :songs
end
