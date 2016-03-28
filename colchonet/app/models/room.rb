class Room < ActiveRecord::Base
  # :title, :location, :description

  def complete_name
    "#{title}, #{location}"
  end
end
