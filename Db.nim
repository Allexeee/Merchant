import random

type
  Want* = enum
    Buy, Sell

  ItemType* = enum
    Sword, Bow, Knife

# Информация о создаваемом предмете
  ItemInfo = tuple
    name: string
    # itemType:ItemType
    costMin: int
    costMax: int

  Item* = tuple
    name: string
    itemType: ItemType
    cost: int

  ClassType = tuple
    name: string
    itemsType: seq[ItemType]

  Client = tuple
    classType: ClassType
    want: Want
    item: Item

var
  classes: seq[ClassType]
  items = [
  ItemType.Sword: (name:"Меч", costMin:5, costMax:15),
  ItemType.Bow: (name:"Лук", costMin:8, costMax:13),
  ItemType.Knife: (name:"Нож", costMin:5, costMax:8)]

classes = @[
  (
    "Воин",
    @[ItemType.Sword, ItemType.Knife]
  ),
  (
    "Лучник",
    @[ItemType.Bow, ItemType.Knife]
  ),
]
# classes.add(("Воин", @[ItemType.Sword, ItemType.Knife]))
# classes.add(("Лучник", @[ItemType.Bow, ItemType.Knife]))

proc createItem(itemInfo:ItemInfo, itemType:ItemType):Item =
  var r = rand(itemInfo.costMin..itemInfo.costMax)
  result.itemType = itemType
  result.name = itemInfo.name
  result.cost = r

randomize()

proc randWant(): Want =
  var r = rand(1)
  case r:
    of 0: return Want.Buy
    of 1: return Want.Sell
    else: discard

proc getRandomClient*(): Client =
  # Выбираем случайный класс для клиента
  assert(classes.len != 0, "Error: Classes not found!")
  var r = rand(high(classes))
  let class: ClassType = classes[r]

  # Выбираем случайный предмет, который клиент будет покупать или продавать
  assert(class.itemsType.len != 0, "Error: Class haven't items type")
  r = rand(high(class.itemsType))
  let itemType = class.itemsType[r]
  let item: Item = createItem(items[itemType], itemType)

  # Случайно выбираем, хочет ли клиент купить или продать
  let want: Want = randWant()

  # "Собираем" клиента
  result.want = want
  result.classType = class
  result.item = item


when isMainModule:
  echo classes
  echo getRandomClient()
  echo getRandomClient()
  echo getRandomClient()
