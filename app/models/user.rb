class User < ActiveRecord::Base
  attr_accessible :email, :name
  validates_presence_of :name, :email

  has_and_belongs_to_many :albums

  def purchase(album)
    unless albums.include? album
      albums << album
      self.save
    end
  end

  def forget_albums
  	albums.clear
  end

end
