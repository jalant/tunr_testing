class Album < ActiveRecord::Base
  attr_accessible :img_url, :name

  validates_presence_of :name
  validates_presence_of :img_url

  has_and_belongs_to_many :users
  has_many :songs
  has_many :artists, through: :songs
end
