type
  ItemIdName = string
  ItemId = distinct int
  FaetureId = distinct int
  FaetureIdName = string
  Faeture = tuple
    id: FaetureId
    val: int
  
  ItemInfoNew* = tuple
    typ: ItemId
    name: string
    features: seq[Faeture]

var
  itemsInfo: seq[ItemInfoNew]
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
  (0.ItemId, "Деревянный меч", 
    @[
      (0.FaetureId, 1), 
      (1.FaetureId, 5)
    ]
  )
]
# var itemInfo: ItemInfoNew

# itemInfo.typ = 0.ItemId
# itemInfo.name = "Обычный меч"
# itemInfo.features = @[(1.FaetureId, 20), (0.FaetureId, 10)]

# itemsInfo.add itemInfo

proc `$` (i: ItemId):string =
  return itemsName[i.int]  

proc `$` (i: FaetureId):string =
  return faeturesName[i.int]  

proc `$` (i: seq[Faeture]):string =
  for ind, value in i:
    result = result & $value.id & "(" & $value.val & ") " 
  
  
proc `$` (item: ItemInfoNew):string =
  return "type: " & $item.typ & ", name: " & $item.name & ", features: " & $item.features  
  
when isMainModule:
  echo itemsInfo
