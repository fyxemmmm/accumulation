SELECT * FROM reviews


select a.*, IF(@tmp=CONCAT(r_content, r_userid),@row_num:=@row_num+1, @row_num:=1) as row_num, @tmp := CONCAT(r_content, r_userid) from 
(
select a.*, b.news_id from 
( SELECT count(*) c ,r_content,r_userid from reviews GROUP BY r_content, r_userid having c > 2 ) a inner join reviews b on a.r_content = b.r_content
) a, (select @row_num:=0, @tmp:='') b

