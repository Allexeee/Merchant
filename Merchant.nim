import random

type
  clientType = object
    class*: string
    item*: string
    coin*: int
    wantBuy*: bool

var
  classes: array[2, string]
  items: array[2, string]

classes = ["Воин", "Лучник"]
items = ["Меч", "Лук"]

randomize(234)
proc randBool(): bool =
  var r = rand(1)
  if(r == 1): return true
  return false

proc newClient(): clientType =
  let r = rand(1)
  result.class = classes[r]
  result.item = items[r]
  result.coin = 10
  result.wantBuy = randBool()



var money = 100

echo "Привет, торговец, как тебя зовут?"
let name: string = readLine(stdin)
echo "Отлично! Итак, ", name, ", ты должен покупать товары у одних клиентов и продавать их другим."
echo "Это просто!"
echo "Но смотри - не останься без денег и товара"
echo "Вот тебе склад туда залезут любые 10 предметов"
echo "Ну а денег у тебя, думаю найдется"
echo "(У Вас ", money, " золотых)"

echo ""

var input = 'q'
while input != 'z':
  var client: clientType = newClient()

  echo "============================="
  echo "У Вас новый клиент!"
  echo "Класс: ", client.class
  if not client.wantBuy:
    echo "Продает: ", client.item
  else:
    echo "Покупает: ", client.item
  echo "По цене: ", client.coin
  echo "============================="

  echo ""
  if (client.wantBuy == false) :
    echo "[X] Купить"
  else:
    echo "[X] Продать"
  echo "[C] Отказаться"

  input = readChar(stdin)
  if input == 'X' or input == 'x':
    if not client.wantBuy:
      money -= client.coin
    else:
      money += client.coin
    echo "Осталось монет: ", money

  echo "Нажмите 'z', чтобы завершить игру"
  input = readChar(stdin)

echo "Нажмите Enter, чтобы завершить игру"
discard readLine(stdin)
echo "Пока!"
