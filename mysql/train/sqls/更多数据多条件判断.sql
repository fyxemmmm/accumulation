SELECT * FROM user_level


update user_level,(select avg(user_total) as avg from user_level ) b set user_rank = 
case
	when  round(user_total/b.avg)>=1 and round(user_total/b.avg) < 2  then '白金用户'
	when  round(user_total/b.avg)>=2 then '黄金用户'
else 
	'吃瓜'
end
where user_total > b.avg

