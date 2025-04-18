CREATE FUNCTION LONGERSTR(str1 VARCHAR(255), str2 VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
  IF CHAR_LENGTH(str1) >= CHAR_LENGTH(str2) THEN
    RETURN str1;
  ELSE
    RETURN str2;
  END IF;
END;


SELECT LONGERSTR('LONGERONE111', 'SHORTERONE'); 
