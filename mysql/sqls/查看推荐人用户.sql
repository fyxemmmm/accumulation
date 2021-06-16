-- 查看推荐人用户
SELECT * FROM webusers

SELECT a.u_name as username, b.u_name as rname from webusers a INNER JOIN webusers b on a.p_id = b.u_id	

select  a.referee, b.u_name  from 
( SELECT GROUP_CONCAT(u_name) as referee, p_id from webusers a GROUP BY a.p_id ) a
INNER JOIN webusers b WHERE a.p_id = b.u_id