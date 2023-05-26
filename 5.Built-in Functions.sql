-- 1. Find Book Titles
SELECT title FROM books
WHERE SUBSTRING(title, 1, 3) = 'The';

-- 02. Replace Titles
SELECT REPLACE(title, 'The', '***') AS title FROM books
WHERE SUBSTRING(title, 1, 3) = 'The';

-- 03. Sum Cost of All Books
SELECT ROUND(SUM(cost), 2) AS total_price FROM books;

-- 04. Days Lived
SELECT CONCAT(first_name,' ', last_name) AS 'Full Name',
TIMESTAMPDIFF(DAY, born, died) AS 'Days Lived'
FROM authors;

-- 05. Harry Potter Books
SELECT title FROM books
WHERE SUBSTRING(title, 1, 12) = 'Harry Potter'
ORDER BY id;


------------------------------------- String Functions-------------------------------
SUBSTRING(String, Position, Length) -- extracts part of a string
REPLACE(String, Pattern, Replacement) -- replaces specific string with another
LTRIM(String) -- remove spaces from either side of string
RTRIM(String) -- remove spaces from either side of string
CHAR_LENGTH(String) -- count number of characters
LENGTH(String) -- get number of used bytes (double for Unicode)
LEFT(String, Count), RIGHT(String, Count) -- get characters from beginning or end of string
LOWER(String), UPPER(String) -- change letter casing
REVERSE(String) -- reverse order of all characters in string
REPEAT(String, Count) -- repeat string
LOCATE(Pattern, String, [Position]) -- locate specific pattern (substring) in string
INSERT(String, Position, Length, Substring) -- Insert substring at specific position

----------------------------- Arithmetical Operators and Numeric functions -----------
-- Name Description
'DIV'  -- Integer division
'/' -- Division operator
'-' -- Minus Operator
'%, MOD' -- Modulo operator
'+' -- Addition operator
'*' -- Multiplication operator
'- (arg)' -- Change sign of argument
-- Numeric Functions
PI() -- get the value of Pi (15 –digit precision)
ABS(Value) -- absolute value
SQRT(Value) -- square root
POW(Value, Exponent) -- raise value to desired exponent
CONV(Value, from_base, to_base) -- Converts numbers between different number bases
ROUND(Value, Precision) -- obtain desired precision
FLOOR(Value) -- return the nearest integer
CEILING(Value) -- return the nearest integer
SIGN(Value) -- returns +1, -1 or 0, depending on value sign
RAND(Seed) -- get a random value in range [0,1). If Seed is not specified, one is assigned at random

-----------------------------------------Wildcards -----------------------------------
-- Used to substitute any other character(s) in a string
'%' -- represents zero, one, or multiple characters
'_' -- represents a single character
-- Can be used in combinationsUsed with LIKE operator in a WHERE clause
WHERE customer_name LIKE '_r%'; -- Find any values that have "r" in second position
WHERE customer_name LIKE 'a%'; -- Find any values that start with "a"
WHERE customer_name LIKE 'a%o'; -- Finds any values that starts with "a" and ends with "o"
'\' -- specify prefix to treat special characters as normal
[charlist] -- specifying which characters to look for
[!charlist] -- excluding characters

---------------------------------------Date Functions--------------------------------
EXTRACT(Part FROM Date) -- extract a segment from a date as an integer
TIMESTAMPDIFF(Part, FirstDate, SecondDate) -- find difference between two dates
'year, %Y, %y', 'month, %M, %m', 'day, %w, %D' -- Part can be any part and format of date or time
YEAR(Date), MONTH(Date), DAY(Date) -- Part can be any part and format of date or time

DATE_FORMAT() -- formats the date value according to the format
SELECT DATE_FORMAT('2017/05/31', '%Y %b %D') AS 'Date';

NOW() -- NOW – obtain current date and time
SELECT NOW();

--------------------------------------------------------------------------------
DATE_FORMAT(date, format)
-- E.g.
SELECT DATE_FORMAT(dateField, '%m/%d/%Y') FROM TableName;
-- See https://www.mysqltutorial.org/mysql-date_format/ for available formats

-- Format Description
%a	Abbreviated weekday name (Sun to Sat)
%b	Abbreviated month name (Jan to Dec)
%c	Numeric month name (0 to 12)
%D	Day of the month as a numeric value, followed by suffix (1st, 2nd, 3rd, ...)
%d	Day of the month as a numeric value (01 to 31)
%e	Day of the month as a numeric value (0 to 31)
%f	Microseconds (000000 to 999999)
%H	Hour (00 to 23)
%h	Hour (00 to 12)
%I	Hour (00 to 12)
%i	Minutes (00 to 59)
%j	Day of the year (001 to 366)
%k	Hour (0 to 23)
%l	Hour (1 to 12)
%M	Month name in full (January to December)
%m	Month name as a numeric value (00 to 12)
%p	AM or PM
%r	Time in 12 hour AM or PM format (hh:mm:ss AM/PM)
%S	Seconds (00 to 59)
%s	Seconds (00 to 59)
%T	Time in 24 hour format (hh:mm:ss)
%U	Week where Sunday is the first day of the week (00 to 53)
%u	Week where Monday is the first day of the week (00 to 53)
%V	Week where Sunday is the first day of the week (01 to 53). Used with %X
%v	Week where Monday is the first day of the week (01 to 53). Used with %x
%W	Weekday name in full (Sunday to Saturday)
%w	Day of the week where Sunday=0 and Saturday=6
%X	Year for the week where Sunday is the first day of the week. Used with %V
%x	Year for the week where Monday is the first day of the week. Used with %v
%Y	Year as a numeric, 4-digit value
%y	Year as a numeric, 2-digit value