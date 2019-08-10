class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
  
  def yellow
    colorize(33)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end