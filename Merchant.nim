import db, terminal

type
  End = enum
    None, Win, Lose

var 
  endGame:End
  money = 100
  inventory*: seq[Item];

include gameHelper


include gameHello

var i: int = 0
while endGame == End.None:
  eraseScreen(stdin)
  setCursorPos(stdin, 0, 0)

  if(i mod 10) == 0 and i != 0:
    money -= 20
    echo "Вы заплатили налог в 20 золотых!"
    echo ""
    if money <= 0 : 
      endGame = End.Lose
      break
    
    let costIncrease:int = rand(10)-5
    var item = db_items.random()
    item.costMin += costIncrease
    item.costMax += costIncrease

    if item.costMin < 1: item.costMin = 1
    if item.costMax < 1: item.costMax = 1

    echo "Цена предмета \"", item.name,"\" изменилась на ", costIncrease 
    echo ""
    
  var (classType, want, item) = getRandomClient()

  echo "У Вас новый клиент! (", i, ")"
  echo "Класс: ", classType.name
  case want
    of Want.Buy: echo "Покупает: ", item.name
    of Want.Sell: echo "Продает: ", item.name
  echo "============================="
  echo ""
  echo "У вас ", money, " монет"

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

  echo ""
  showInventory()

  while true:
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
            if money <= 0 : endGame = End.Lose
            inventory.add(item)
          else:continue
        else:
          if itemIndex != -1:
            money += costSell
            if money >= 200 : endGame = End.Win
            inventory.del(itemIndex)
          else:continue
        # echo "Монет: ", money
        break
      of 'C', 'c':
        break
      else:
        continue

  inc(i)

eraseScreen(stdin)
setCursorPos(stdin, 0, 0)

case endGame:
  of End.Win:
    echo "Вы богач! Вы неплохо обращаетесь с деньгами!"
  of End.Lose:
    echo "Вы банкрот! Вы совсем не умеете обращаться с деньгами..."
  else:
    echo "Что-то пошло не так... Сообщите разработчику"

echo "Нажмите на любую клавишу, чтобы завершить программу"

try:
  discard getch()
except:
  echo ""