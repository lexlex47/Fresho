require './lib/watermelon'

class Creator

  TYPES = {
    watermelon: WaterMelon
  }

  def self.create(type,name)
    TYPES[type].new(name)
  end

end