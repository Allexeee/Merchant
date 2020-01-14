import Db

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

while true:
  var (classType, want, itemType) = getRandomClient()

  echo "============================="
  echo "У Вас новый клиент!"
  echo "Класс: ", classType.name
  case want
    of Want.Buy: echo "Покупает: ", itemType
    of Want.Sell: echo "Продает: ", itemType
  echo "По цене: ", 10
  echo "============================="

  echo ""
  case want
    of Want.Buy: echo "[X] Продать"
    of Want.Sell:
      if(money-10>0): echo "[X] Купить"
  
  echo "[C] Отказаться"

  var input = readChar(stdin)
  if input == 'X' or input == 'x':
    if want == Want.Buy and money-10>0:
      money += 10
    else:
      money -= 10
    echo "Монет: ", money

  input = readChar(stdin)
  