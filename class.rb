class Car
  def initialize(name)
    @name = name
  end

  def dispname
    print(@name,"\n")
  end

end

car = Car.new("kodai") # => #<Car:0x007ffe5488a568 @name="kodai">
car.dispname 

car2 = Car.new("takahashi") # => #<Car:0x007ffe54889cd0 @name="takahashi">
car2.dispname 
