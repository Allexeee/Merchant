import Db, terminal

var money = 100

eraseScreen(stdin)
setCursorPos(stdin, 0, 0)
echo "Привет, торговец, как тебя зовут?"
let name: string = readLine(stdin)
hideCursor()

echo """Отлично! Итак, """, name,
    """, ты должен покупать товары у одних клиентов и продавать их другим.
  Это просто!
  Но смотри - не останься без денег и товара
  Вот тебе склад туда залезут любые 10 предметов
  Ну а денег у тебя, думаю найдется
  (У Вас """, money, """ золотых)
  """

echo "Нажмите на любую клавишу, чтобы продолжить"

discard getch()

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

  echo ""
  case want
    of Want.Buy: echo "[X] Продать"
    of Want.Sell:
      if(money-10 > 0): echo "[X] Купить"

  echo "[C] Отказаться"

  while true:
    var input = getch()
    case input:
      of 'X', 'x':
        if want == Want.Sell:
          if money-10 > 0:
            money -= 10
        else:
          money += 12
        # echo "Монет: ", money
        break
      of 'C', 'c':
        break
      else:
        continue

  inc(i)
