import random

type
  Want* = enum
    Buy, Sell

  ItemType* = enum
    Sword, Bow, Knife, Axe, Ore, Potion, HeavyArmor, LightArmor

# Информация о создаваемом предмете
  ItemInfo* = tuple
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
  db_items* = [
  ItemType.Sword: (name:"Меч", costMin:5, costMax:15),
  ItemType.Bow: (name:"Лук", costMin:8, costMax:18),
  ItemType.Knife: (name:"Нож", costMin:3, costMax:13),
  ItemType.Axe: (name:"Топор", costMin:5, costMax:17),
  ItemType.Ore: (name:"Железная руда", costMin:3, costMax:20),
  ItemType.Potion: (name:"Зелье здоровья", costMin:3, costMax:10),
  ItemType.HeavyArmor:(name:"Тяжелые доспехи", costMin:10, costMax:20),
  ItemType.LightArmor:(name:"Легкие доспехи", costMin:5, costMax:18)]

classes = @[
  (
    "Воин",
    @[ItemType.Sword, ItemType.Knife, ItemType.Potion, ItemType.HeavyArmor]
  ),
  (
    "Лучник",
    @[ItemType.Bow, ItemType.Knife, ItemType.Potion, ItemType.LightArmor]
  ),
  (
    "Кузнец",
    @[ItemType.Sword, ItemType.Ore, ItemType.HeavyArmor, ItemType.LightArmor]
  ),
  (
    "Берсерк",
    @[ItemType.Axe, ItemType.HeavyArmor]
  )
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
  assert(class.itemsType.len != 0, "Error: Class haven't db_items type")
  r = rand(high(class.itemsType))
  let itemType = class.itemsType[r]
  let item: Item = createItem(db_items[itemType], itemType)

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
