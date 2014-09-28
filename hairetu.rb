def wa(num,num1)
  return num + num1
end

def sa(num,num1)
  return num - num1
end

def seki(num,num1)
  return num * num1
end

a = [1,2,3,4,5]

ans =  wa(a[0],a[1]) # => 3
ans1= seki(a[2],a[4]) # => 15
ans2=  sa(a[1],a[3]) # => -2

puts ans,ans1,ans2
