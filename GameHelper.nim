import random

randomize()


proc findInInvetory(item:Item):int =
  for i, value in inventory:
    if value.itemType == item.itemType: return
    inc(result)
  result = -1
  
proc showInventory(): void =
  var str:string = ""
  for i, value in inventory:
    if value.name == "": continue
    str = str & "\t" & value.name & " (" & $value.cost & ")"
  echo "Инвентарь: ",str

proc random[T]*(list:openArray[T]):T =
  let r = rand(list.len-1)
  return list[r]

proc random[T]*(list:seq[T]):T =
  let r = rand(list.len-1)
  return list[r]