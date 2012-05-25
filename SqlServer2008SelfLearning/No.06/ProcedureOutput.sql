/*
	ストアドプロシージャ
	出力パラメータ
*/
use Test;

if object_id( 'procedure5', 'p' ) is not null
	drop procedure procedure5;
go


create procedure procedure5
	@param1 int,
	@param2 int output	-- outputキーワードを付けて出力パラメータ
as
	select * from t1 where c1 > @param1
	select @param2 = @@rowcount;


declare @result int;
execute procedure5 @param1 = 1, @param2 = @result output;
select @result;
go
