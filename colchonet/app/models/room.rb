class Room < ActiveRecord::Base
  # :title, :location, :description
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates_presence_of :title, :location, :description

  def complete_name
    "#{title}, #{location}"
  end
end
