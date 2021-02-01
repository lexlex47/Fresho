require 'watermelon'

class Creator

  TYPES = {
    watermelon: WaterMelon
  }

  def self.create(type)
    TYPES[type].new
  end

end