/*
	一時テーブル
	テーブル変数
	ユーザ定義テーブル型
	cte( 共通テーブル式 )
*/
use Test;


-- 一時テーブル( ユーザが接続している間だけ有効で、接続が切れると自動的に削除される )
-- create table #table_nameでも作成可能
-- select intoでに作成可能
select row_number() over( order by c1 ) as row_no, *
into #temp
from t2;


select *
from #temp
where row_no between 3 and 5;


-- 明示的に削除も可能
drop table #temp;
go


-- テーブル変数
-- バッチの終了時に自動的に削除される
-- select intoでテーブル変数を作成できない
declare @t table(
	row_no int,
	c1 int,
	c2 varchar( 3 ) );

insert into @t
select row_number() over( order by c1 ) as row_no, *
from t2;

select *
from @t
where row_no between 3 and 5;
go


-- ユーザ定義テーブル型
-- ストアドプロシージャの入力パラメータ型として利用できる
create type type1
as table(
	row_no int,
	c1 int,
	c2 varchar( 3 ) );
go	-- <- 必要

declare @t type1;

insert into @t
select row_number() over( order by c1 ) as row_no, *
from t2;

select *
from @t
where row_no between 3 and 5;

-- 明示的な削除が必要
drop type type1;
go


-- cte( 共通テーブル式 )
-- インラインビューを読みやすくしたい場合などでお勧め
with cte
as(
	select row_number() over( order by c1 ) as row_no, *
	from t2 )
select *
from cte
where row_no between 3 and 5;


