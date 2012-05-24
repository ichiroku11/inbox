/*
	execute
	sp_executesql

	top
*/
use Test;


-- ローカル変数
declare @v int;

select @v = c1
from t1
where c1 = 1;	-- 結果が1行にならないと、最後に取得した結果が変数に格納されるので注意

select @v;
go


-- executeステートメントによる動的SQL
-- テーブル名やカラム名はパラメータ化できない
execute( 'select * from t1' );		-- ()が必要

declare @table varchar( 2 ) = 't1';
execute( 'select * from ' + @table );
go


-- sp_executesqlシステム ストアド プロシージャによる動的SQL
declare @sql nvarchar( max );
set @sql = N'select * from t1';
execute sp_executesql @sql;

declare @table varchar( 2 ) = 't1';
--execute sp_executesql 'select * from ' + @table;
-- ↑エラー
-- 文字列連結が完了したSQLステートメントを引数に与える必要がある
go


-- sp_executesqlではSQLのパラメータ化が行える
-- テーブル名やカラム名はパラメータ化できない
execute sp_executesql N'select * from t1 where c1 >= @p1 and c1 <= @p2',
	N'@p1 int, @p2 int',
	@p1 = 1, @p2 = 3;
go


-- TOP句
-- 括弧を使って変数を記述できる
declare @n int = 3;
select top( @n ) *
from t1
order by c1;
go


