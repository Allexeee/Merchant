import random

type
  ItemIdName = string
  ItemId = distinct int
  FaetureId = distinct int
  FaetureIdName = string
  Faeture = tuple
    id: FaetureId
    val: int
  
  ItemInfo* = tuple
    typ: ItemId
    name: string
    features: seq[Faeture]

var
  itemsInfo: seq[ItemInfo]
  itemsName: seq[ItemIdName]
  faeturesName: seq[FaetureIdName]

itemsName = @[
  ("Меч"),
  ("Лук"),
  ("Нож"),
]

faeturesName = @[
  "Урон",
  "Прочность"
]

itemsInfo = @[
  (0.ItemId, "Обычный меч", 
    @[
      (0.FaetureId, 1), 
      (1.FaetureId, 5)
    ]
  ),
  (1.ItemId, "Обычный лук",
    @[
      (0.FaetureId, 2),
      (1.FaetureId, 3)
    ]
  ),
]

proc `$`* (i: ItemId):string =
  return itemsName[i.int]  

proc `$`* (i: FaetureId):string =
  return faeturesName[i.int]  

proc `$`* (i: seq[Faeture]):string =
  for ind, value in i:
    result = result & $value.id & "(" & $value.val & ") " 
  
proc `$`* (item: ItemInfo):string =
  return "type: " & $item.typ & ", name: " & $item.name & ", features: " & $item.features  
  
proc getRandomItem*():ItemInfo =
  let r = rand(itemsInfo.len-1)
  return itemsInfo[r]

proc sumCostFaeture*(list: seq[Faeture]):int = 
  for i, value in list:
    result += value.val

when isMainModule:
  echo itemsInfo
