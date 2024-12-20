### Криптографічний захист клієнт-серверної взаємодії в СКБД PostgreSQL

1. Встановити OpenSSL-пакет. В терміналі командного рядку запустити утиліту openssl та переглянути перелік доступних команд.

![image](https://github.com/user-attachments/assets/61350ba7-8dd7-4831-8aa6-2712d1a8dd34)

2. Створити самопідписаний сертифікат для сервера СКБД PostgreSQL з наступними параметрами:
- атрибути C=UA, L=Odessa, O=OPU, OU=group, CN=surname.op.edu.ua, де group – назва вашої групи латиницею, surname – ваше прізвище латиницею
- строк дії сертифікату = (variant * 10) днів, де variant – значення вашого варіанту.

```
openssl req -new -x509 -days 70 -nodes -text -out server.crt -keyout server.key -subj "/C=UA/L=Odesa/O=OPU/OU=AI-201/CN=Evchev.op.edu.ua"
```

![image](https://github.com/user-attachments/assets/62595d19-b222-4dc7-8fcb-50d885d4b590)

3. Переглянути вміст сертифікату та визначити алгоритми створення відкритого ключа, а також алгоритм встановлення цифрового підпису.

```
openssl x509 -in server.crt -text -noout
```

![image](https://github.com/user-attachments/assets/faaf449f-ae80-4b52-8137-408a73098c0c)
![image](https://github.com/user-attachments/assets/b16e2177-fff9-42d7-acab-578b691ec1fd)

4. Скопіювати створений сертифікат відкритого ключа та закритий ключ до каталогу сервера СКБД PostgreSQL, яка використовувалася у попередній лабораторній роботі. У конфігураційному файлі postgresql.conf налаштувати значення SSL-параметрів для підтримки SSL-з'єднання між сервером та клієнтами.

![image](https://github.com/user-attachments/assets/8bafbd11-147b-4275-9da3-a29e3b6b1633)

5. Використовуючи програму psql, встановити TSL/SSL-з'єднання з БД за прикладом з попередньої лабораторної роботи, але використовуючи формат параметрів "host=var1 port=var2 dbname=var3 user=var4 password=var5 sslmode=var6". Визначити версію TSL-протоколу та перелік використаних криптоалгоритмів.

```
psql "host=localhost port=5432 dbname=postgres user=evchev password=4213 sslmode=require"
```

![image](https://github.com/user-attachments/assets/0e8d974d-d809-4522-afb6-19189c27d13b)

6. Встановити ПЗ контейнерної віртуалізації Docker та запустити Docker через ваш Docker-обліковий запис.

![image](https://github.com/user-attachments/assets/0da2c970-8ea5-40da-a294-0fa5dd8a3665)

7. Запустити Docker-контейнер СКБД PostgreSQL, використовуючи раніше розглянуті приклади (порт прослуховування запитів СКБД PostgreSQL = 5466).

![image](https://github.com/user-attachments/assets/7ae60012-418c-44ed-93ea-cd4b5fdd3f2e)

8. У Docker-контейнері встановити програмний пакунок аналізу мережевих пакетів tcpdump. Отримати перелік мережевих інтерфейсів на вашому комп’ютері.

![image](https://github.com/user-attachments/assets/a70062e6-8529-4a3a-9e55-91f189a13787)

![image](https://github.com/user-attachments/assets/0ec6587c-9565-4c7e-812a-e33e550e9ffa)

9. Провести запуск програми аналізу мережевих пакетів для кожного мережевого інтерфейсу поки не буде знайдено активний інтерфейс, який взаємодіє з мережею Internet та виводить на екран інформацію про ці пакети.

![image](https://github.com/user-attachments/assets/782957e2-9f0e-4220-b159-8fb03ac933a4)

10. Запустити програму аналізу мережевих пакетів в режимі прослуховування обраного мережевого інтерфейсу та налаштувати її на перегляд пакетів, які пов`язані з портом 5466, зберігаючи зміст пакетів в окремому файлі через перенаправлення потоку, наприклад, > res.dump. Результати роботи будуть використанні у наступних завданнях.

![image](https://github.com/user-attachments/assets/0abe0a94-f878-4eeb-a3d1-86dc56498d75)

11. Запустити окрему термінальну консоль та становити зв'язок із СКБД PostgreSQL, яка запущена через Docker-контейнер. Після успішного встановлення визначити версію TSL-протоколу та перелік використаних криптографічних алгоритмів.

![image](https://github.com/user-attachments/assets/f1b54427-977b-4795-a77c-0cb4a00f5058)

12. Виконати команду створення користувача за прикладом з лабораторної роботи No6.

![image](https://github.com/user-attachments/assets/66d42937-e3a9-43fc-9bde-7d60786e3d36)

13. Проаналізувати вміст перехоплених пакетів, які було збережено у файлі, наприклад, res.dump. Підтвердити передачу деяких даних у відкритому вигляді.

![image](https://github.com/user-attachments/assets/ac0bf71b-dec6-4be4-88a8-f377a5e0856c)

14. Повторити пункт 11, встановивши зв’язок із СКБД, але вже через TLS/SSL-з’єднання.

![image](https://github.com/user-attachments/assets/aa26e8dd-c653-4d93-bb49-4413eafc399c)

15. Проаналізувати вміст перехоплених пакетів в програмі-аналізаторі

![image](https://github.com/user-attachments/assets/f5a57bec-b407-4de1-a891-cb82485cec79)
![image](https://github.com/user-attachments/assets/be2a6640-2281-47f5-8c69-4f367ea82c93)
![image](https://github.com/user-attachments/assets/c63a92ec-55fb-47a9-a4eb-94bf633e0b27)

