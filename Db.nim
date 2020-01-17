import random

type
  Want* = enum
    Buy, Sell

  ItemType* = enum
    Sword, Bow, Knife

  ClassType = tuple
    name: string
    itemsType: seq[ItemType]

  Client = tuple
    classType: ClassType
    want: Want
    itemType: ItemType

var
  classes*: seq[ClassType]

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
  let item: ItemType = class.itemsType[r]

  # Случайно выбираем, хочет ли клиент купить или продать
  let want: Want = randWant()

  # "Собираем" клиента
  result.want = want
  result.classType = class
  result.itemType = item

when isMainModule:
  echo classes
  echo getRandomClient()
  echo getRandomClient()
  echo getRandomClient()
