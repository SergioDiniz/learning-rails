class Review < ActiveRecord::Base
  
  POINTS = (1..5).to_a

  belongs_to :user
  belongs_to :room, counter_cache: true
  
  # não coloca o attr
  # attr_accessor :points
  
  validates_uniqueness_of :user_id, scope: :room_id
  validates_presence_of :user_id, :room_id, :points
  validates_inclusion_of :points, in: POINTS

  def self.stars
  	(average(:points) || 0).round
  end

end
