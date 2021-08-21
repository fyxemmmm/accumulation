SELECT * FROM users_buy

SELECT * FROM users_score



SELECT user_name, max(paymoney) as maxpay from users_buy GROUP BY user_name

update users_score as a 
INNER JOIN (SELECT user_name, max(paymoney) as maxpay from users_buy GROUP BY user_name
) as b  on a.user_name = b.user_name

set a.user_score = a.user_score + (b.maxpay * 0.1)