class Room < ActiveRecord::Base
  # :title, :location, :description
  belongs_to :user

  validates_presence_of :title, :location, :description

  def complete_name
    "#{title}, #{location}"
  end
end
