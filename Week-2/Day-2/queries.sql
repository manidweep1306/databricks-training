-- day 2: date manipulation practice queries

-- question 1: get the current date
current_date()
-- answer: 2026-05-17

-- question 2: get the current date and time
current_timestamp()
-- answer: 2026-05-17 14:30:45.123

-- question 3: extract date from '2026-05-17 14:30:45'
date('2026-05-17 14:30:45')
-- answer: 2026-05-17

-- question 4: extract the year from '2026-05-17'
year('2026-05-17')
-- answer: 2026

-- question 5: extract the month from '2026-05-17'
month('2026-05-17')
-- answer: 5

-- question 6: extract the day from '2026-05-17'
day('2026-05-17')
-- answer: 17

-- question 7: find the day of week for '2026-05-17' (1=Sunday, 7=Saturday)
dayofweek('2026-05-17')
-- answer: 1 (sunday)

-- question 8: add 10 days to '2026-05-17'
date_add('2026-05-17', 10)
-- answer: 2026-05-27

-- question 9: subtract 5 days from '2026-05-17'
date_sub('2026-05-17', 5)
-- answer: 2026-05-12

-- question 10: calculate the number of days between '2026-05-17' and '2026-05-22'
datediff('2026-05-22', '2026-05-17')
-- answer: 5

-- question 11: format '2026-05-17' as 'dd-MM-yyyy'
date_format('2026-05-17', 'dd-MM-yyyy')
-- answer: 17-05-2026

-- question 12: calculate age in years for someone born on '2000-05-17'
year(current_date()) - year('2000-05-17')
-- answer: 26

-- question 13: add 3 months to '2026-05-17' (calculate days in 3 months)
date_add('2026-05-17', 90)
-- answer: 2026-08-15

-- question 14: find how many days until end of year from '2026-05-17'
datediff(date('2026-12-31'), '2026-05-17')
-- answer: 229

-- question 15: get the first day of current month
date_sub(current_date(), day(current_date()) - 1)
-- answer: 2026-05-01
