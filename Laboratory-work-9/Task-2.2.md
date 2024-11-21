# Перевірка надійності пароля за списком "10000 найгірших паролів"

2.2.1 В репозиторії [посилання](https://github.com/danielmiessler/SecLists/tree/master/Passwords) розміщено файли зі списку "10000 найгірших паролів", назви яких представлено в таблиці 1. Отримати файл, номер якого відповідає вашому варіанту.

![image](https://github.com/user-attachments/assets/f8ac6c34-f842-4872-9101-dff2d172f0b6)

2.2.2 Створити таблицю в БД СКБД PostgreSQL, назва якої відповідає назві файлу, та завантажити вміст файлу у таблицю, використовуючи будь-який засіб імпорту, наприклад, команду \COPY утиліти psql.

![image](https://github.com/user-attachments/assets/c5c0a051-ec04-44b1-ad5f-a3b74bd9e5a4)

2.2.3 Створити функцію user_register на мові програмування PL/pgSQL, яка буде забороняти створювати пароль, якщо він є у таблиці гірших паролів.

```
CREATE OR REPLACE FUNCTION user_register(v_password VARCHAR)
RETURNS BOOLEAN
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM unkown_azul WHERE passname = v_password) THEN
        RAISE NOTICE 'Password "%" is on the list of worst passwords.', v_password;
        RETURN FALSE;
    ELSE
        RAISE NOTICE 'Password "%" allowed.', v_password;
        RETURN TRUE;
    END IF;
END;
$$ LANGUAGE plpgsql;
```

2.2.4 Провести тестування роботи функції user_register за двома тестовими сценаріями (правильний та неправильний).

Правильний сценарій:

![image](https://github.com/user-attachments/assets/7040dfe0-754d-43cc-b6e3-729961bd102c)

Неправильний сценарій:

![image](https://github.com/user-attachments/assets/e59678ca-0e17-4a99-b1b7-c58f484ace81)
