type
  ItemIdName = string
  ItemId = int
  FaetureId = int

  ItemInfoNew* = tuple
    typ: ItemId
    name: string
    features: seq[FaetureId]

var
  itemsInfo: seq[ItemInfoNew]
  itemsName: seq[ItemIdName]

itemsName = @[
  ("Меч"),
  ("Лук"),
  ("Нож"),
]

var itemInfo: ItemInfoNew

itemInfo.typ = 1
itemInfo.name = "Test Sword"
itemInfo.features = @[0, 1]

itemsInfo.add itemInfo

proc getNameTypeItem(i: ItemId):string =
  return itemsName[i]  


when isMainModule:
  echo itemInfo.typ.getNameTypeItem
