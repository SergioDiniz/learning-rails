class Room < ActiveRecord::Base
  extend FriendlyId
  # :title, :location, :description
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates_presence_of :title, :location, :description, :slug

  friendly_id :title, use: [:slugged, :history]

  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
  	if query.present?
  		where(['location LIKE :query OR
  				title LIKE :query OR
  				description LIKE :query', query: "%#{query}%"])
  	else
  		all
  	end
  end
end
