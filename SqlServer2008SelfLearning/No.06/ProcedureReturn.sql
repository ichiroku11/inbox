/*
	ストアドプロシージャ
	結果を返す
*/
use Test;

if object_id( 'procedure7', 'p' ) is not null
	drop procedure procedure7;
go


create procedure procedure7
	@param1 int = null
as
	if @param1 is null
		begin
			print 'パラメータ未入力！'
			return ( 99 )	-- 終了
		end
	select * from t1 where c1 > @param1;
	return ( 0 );


declare @result int;
execute @result = procedure7;
select @result;
execute @result = procedure7 @param1 = 1;
select @result;
go
