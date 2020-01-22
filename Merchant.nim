import Db, terminal

type
  End = enum
    None, Win, Lose

var 
  endGame:End
  money = 100
  inventory: seq[Item];

include Hello

# proc findInInventory(item:Item):Item =
#   for i, value in inventory:
#     if value.itemType == item.valueType: return
#     inc(result)
#   result = -1

proc findInInvetory(item:Item):int =
  for i, value in inventory:
    if value.itemType == item.itemType: return
    inc(result)
  result = -1

var i: int = 0
while true:
  # discard getch()
  eraseScreen(stdin)
  setCursorPos(stdin, 0, 0)

  var (classType, want, item) = getRandomClient()

  echo "У Вас новый клиент! (", i, ")"
  echo "Класс: ", classType.name
  case want
    of Want.Buy: echo "Покупает: ", item.name
    of Want.Sell: echo "Продает: ", item.name
  echo "============================="
  echo "У вас ", money, " монет"

  var str:string = ""
  for i, value in inventory:
    str = str & "\t" & value.name & " (" & $value.cost & ")"
  echo "Инвентарь: ",str
  echo ""

  let itemIndex = findInInvetory(item)
  let costSell = item.cost + (0.1 * item.cost.toFloat).toInt

  case want
    of Want.Buy: 
      if itemIndex != -1:
        echo "[X] Продать ",item.name," за ", costSell
      else:
        echo "У вас нет этого предмета"
    of Want.Sell:
      if(money-item.cost > 0): 
        if inventory.len < 10:
          echo "[X] Купить ",item.name," за ", item.cost
        else: echo "Инвентарь заполнен"
      else: echo "Не хватает монет"

  echo "[C] Отказаться"

  while endGame == End.None:
    var input:char
    try:
      input = getch()
    except:
      echo "Используйте другую раскладку клавиатуры"
    case input:
      of 'X', 'x':
        if want == Want.Sell:
          if money - item.cost > 0 and inventory.len < 10:
            money -= item.cost
            inventory.add(item)
          else:continue
        else:
          if itemIndex != -1:
            money += costSell
            inventory.del(itemIndex)
          else:continue
        # echo "Монет: ", money
        break
      of 'C', 'c':
        break
      else:
        continue

  inc(i)
