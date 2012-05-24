/*
	ストアドプロシージャ
*/

use Test;

-- ストアドプロシージャの作成と実行
if object_id( 'procedure1', 'p' ) is not null
	drop procedure procedure1;
go

create procedure procedure1
as select * from t1 where c1 > 2;

execute procedure1;


-- 引数があるストアドプロシージャの作成と実行
if object_id( 'procedure2', 'p' ) is not null
	drop procedure procedure2;
go

create procedure procedure2
	@param1 int = 2	-- 初期値は省略可能
as select * from t1 where c1 > @param1;

execute procedure2;	-- @param1 = 2で実行
execute procedure2 1;
execute procedure2 @param1 = 1;
-- 複数の引数はカンマ区切りでOK
go

-- return文によるストアドプロシージャの終了
if object_id( 'procedure3', 'p' ) is not null
	drop procedure procedure3;
go

create procedure procedure3
	@param1 int = null
as
	if @param1 is null
		begin
			print 'パラメータ未入力！'
			return	-- 終了
		end
	select * from t1 where c1 > @param1;

execute procedure3;
execute procedure3 @param1 = 2;
go