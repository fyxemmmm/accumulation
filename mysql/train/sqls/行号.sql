select * from products



select *,IF(p_type=@bak,@row_num:=@row_num+1,@row_num:=1), @bak:=p_type from 
(select * FROM products ORDER BY p_type, p_view desc) a, (select @row_num:=0, @bak:='') b

