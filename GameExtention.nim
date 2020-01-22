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
