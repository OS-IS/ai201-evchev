# Перевірка надійності пароля за визначеними умовами

2.3.1 Припустимо, що з урахуванням рекомендацій посібника NIST 800-63 «Digital Identity Guidelines. Authentication and Lifecycle Management», розміщенного за [адресою](https://pages.nist.gov/800-63-3/sp800-63b.html), пропонуються наступні умови надійності паролю користувача:
- довжина рядка не менше 15 символів;
- не менше 2 символів – цифра;
- не менше 4 символів у нижньому регістрі;
- не менше 4 символів у верхньому регістрі;
- не менше 2 спеціальних символів з множини {!@#$%^&*}

Оновити програмний код створеної функції user_register з новою назвою – user_register_secure, додавши до нього реалізацію алгоритму перевірку надійності паролю.

```
CREATE OR REPLACE FUNCTION user_register_secure(v_password VARCHAR)
RETURNS BOOLEAN
AS $$
DECLARE
    special_chars CONSTANT TEXT := '!@#$%^&*';
BEGIN
    IF LENGTH(v_password) < 15 THEN
        RAISE NOTICE 'The password must be at least 15 characters long.';
        RETURN FALSE;
    ELSIF (SELECT COALESCE(SUM(1), 0) FROM regexp_matches(v_password, '[a-z]', 'g')) < 4 THEN
        RAISE NOTICE 'The password must contain at least 4 lowercase characters.';
        RETURN FALSE;
    ELSIF (SELECT COALESCE(SUM(1), 0) FROM regexp_matches(v_password, '[A-Z]', 'g')) < 4 THEN
        RAISE NOTICE 'The password must contain at least 4 characters in uppercase.';
        RETURN FALSE;
    ELSIF (SELECT COALESCE(SUM(1), 0) FROM regexp_matches(v_password, '[0-9]', 'g')) < 2 THEN
        RAISE NOTICE 'The password must contain at least 2 digits.';
        RETURN FALSE;
    ELSIF (SELECT COALESCE(SUM(1), 0) FROM regexp_matches(v_password, '[' || special_chars || ']', 'g')) < 2 THEN
        RAISE NOTICE 'The password must contain at least 2 special characters.';
        RETURN FALSE;
    ELSIF EXISTS (SELECT 1 FROM unkown_azul WHERE passname = v_password) THEN
        RAISE NOTICE 'Password "%" is on the list of worst passwords.', v_password;
        RETURN FALSE;
    END IF;

    RAISE NOTICE 'Password "%" successfully passed the reliability check.', v_password;
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;
```

2.3.2 Провести тестування роботи функції user_register за двома тестовими сценаріями (правильний та неправильний).

Правильний сценарій:

![image](https://github.com/user-attachments/assets/4e2fe3d5-b87e-4f4f-ac8c-c0c9180ece20)

Неправильний сценарій:

![image](https://github.com/user-attachments/assets/bec4ddcb-4345-49e4-83fa-f86463e3fc2e)
