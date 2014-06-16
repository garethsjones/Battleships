class Border
  
  def initialize(label)
    @label = label  
  end
  
  def status(show_hidden = false); @label; end
  def name; @label; end
  
end