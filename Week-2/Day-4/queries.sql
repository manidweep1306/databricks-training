-- day 4: strdatanum assignment

-- assignment 1: format customer name and email together
-- create a formatted string with uppercase first name and domain extracted from email
select concat(upper('john'), ' - ', substr('john.doe@company.com', instr('john.doe@company.com', '@') + 1))
-- answer: JOHN - company.com

-- assignment 2: calculate customer age and format birth date
-- extract year from birth date, calculate age, and format age as number with 0 decimal places
select round(year(current_date()) - year('1990-05-15'), 0) as age
-- answer: 36

-- assignment 3: process order details with multiple functions
-- combine customer name (uppercase), order value (rounded to 2 decimals), and order date (formatted)
select concat(upper('alice'), ' | Order: $', round(249.567, 2), ' | Date: ', date_format('2026-05-17', 'MM-dd-yyyy'))
-- answer: ALICE | Order: $249.57 | Date: 05-17-2026

-- assignment 4: calculate discount based on purchase amount
-- apply 10% discount to purchase amount and round to nearest cent
select round(power(100, 1) * 0.9, 2) as discounted_price
-- answer: 90.00

-- assignment 5: extract and format customer information
-- extract area code from phone number, last name from full name, and calculate tenure
select concat('Area: ', substr('555-123-4567', 1, 3), ' | Name: ', upper(substr('Smith, John', 1, instr('Smith, John', ',') - 1)), ' | Tenure: ', year(current_date()) - 2015, ' years')
-- answer: Area: 555 | Name: SMITH | Tenure: 11 years

-- assignment 6: format currency and apply percentage calculation
-- calculate 15% tax on amount and format with proper rounding
select concat('Amount: $', round(500.00, 2), ' | Tax (15%): $', round(500.00 * 0.15, 2), ' | Total: $', round(500.00 * 1.15, 2))
-- answer: Amount: $500.00 | Tax (15%): $75.00 | Total: $575.00

-- assignment 7: date calculations for project timeline
-- calculate project duration in days and weeks
select concat('Duration: ', datediff('2026-12-31', '2026-05-17'), ' days | ', round(datediff('2026-12-31', '2026-05-17') / 7.0, 1), ' weeks')
-- answer: Duration: 229 days | 32.7 weeks

-- assignment 8: clean and validate customer data
-- remove spaces from customer ID, convert to uppercase, and check length
select concat('Customer ID: ', upper(trim('  CUST123  ')), ' | ID Length: ', length(trim('  CUST123  ')))
-- answer: Customer ID: CUST123 | ID Length: 7

-- assignment 9: create product description with multiple transformations
-- combine product name (title case format), price (with currency), and discount info
select concat(upper(substr('laptop computer', 1, 1)), lower(substr('laptop computer', 2)), ' | Price: $', round(1299.99, 2), ' | Discount: ', floor(greatest(5, 15)), '%')
-- answer: Laptop computer | Price: $1299.99 | Discount: 15%

-- assignment 10: generate customer report line
-- combine all information: formatted name, age calculation, membership duration, and account balance
select concat('Customer: ', upper('john'), ' | Age: ', round(year(current_date()) - year('1985-03-20'), 0), ' | Member Since: ', year('2015-01-10'), ' | Balance: $', round(least(5000, power(100, 1)), 2))
-- answer: Customer: JOHN | Age: 41 | Member Since: 2015 | Balance: $100.00
