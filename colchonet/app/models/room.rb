class Room < ActiveRecord::Base
  extend FriendlyId
  # :title, :location, :description
  belongs_to :user
  has_many :reviews, dependent: :destroy

  # associar o upload da imagem a quarto
  mount_uploader :picture, PictureUploader

  validates_presence_of :title, :location, :description, :slug

  friendly_id :title, use: [:slugged, :history]

  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
  	if query.present?
  		where(['location ILIKE :query OR
  				title ILIKE :query OR
  				description ILIKE :query', query: "%#{query}%"])
  	else
  		all
  	end
  end
end
