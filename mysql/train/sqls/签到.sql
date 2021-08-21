SELECT * FROM user_sign 


select *, IF(user_name=@bak and DATEDIFF(sign_date,@pre_date)=1,@row_num:=@row_num+1,@row_num:=1), @bak:=user_name, @pre_date:=sign_date from (
SELECT user_name, sign_date from user_sign GROUP BY user_name, sign_date order by user_name, sign_date asc
) a, (select @row_num:=1, @bak='', @pre_date:='' ) b