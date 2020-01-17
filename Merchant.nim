import Db, terminal

var 
  money = 100
  inventory: seq[ItemType];

include Hello

var i: int = 0
while true:
  # discard getch()
  eraseScreen(stdin)
  setCursorPos(stdin, 0, 0)

  var (classType, want, itemType) = getRandomClient()

  echo "У Вас новый клиент! (", i, ")"
  echo "Класс: ", classType.name
  case want
    of Want.Buy: echo "Покупает: ", itemType, " по цене 12"
    of Want.Sell: echo "Продает: ", itemType, " по цене 10 (можно продать за 12)"
  echo "============================="
  echo "У вас ", money, " монет"
  var str:string = ""
  for i, value in inventory:
    str = str & "\t" & $value
  echo "Инвентарь: ",str
  echo ""
  let itemIndex = inventory.find(itemType) 
  case want
    of Want.Buy: 
      if itemIndex != -1:
        echo "[X] Продать"
      else:
        echo "У вас нет этого предмета"
    of Want.Sell:
      if(money-10 > 0): 
        if inventory.len < 10:
          echo "[X] Купить"
        else: echo "Инвентарь заполнен"
      else: echo "Не хватает монет"

  echo "[C] Отказаться"

  while true:
    var input = getch()
    case input:
      of 'X', 'x':
        if want == Want.Sell:
          if money-10 > 0 and inventory.len < 10:
            money -= 10
            inventory.add(itemType)
          else:continue
        else:
          if itemIndex != -1:
            money += 12
            inventory.del(itemIndex)
          else:continue
        # echo "Монет: ", money
        break
      of 'C', 'c':
        break
      else:
        continue

  inc(i)
