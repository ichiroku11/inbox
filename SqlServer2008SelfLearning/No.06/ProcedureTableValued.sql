/*
	ストアドプロシージャ
	テーブル値パラメータの利用
*/
use Test;

-- ユーザ定義テーブル型を作成
if object_id( 'valuelist', 'u' ) is not null
	drop type valuelist;
go

create type valuelist
as table( value int );
go


-- 可変長引数の場合はテーブル値パラメータ( ユーザ定義テーブル型を入力パラメータとして )を利用
if object_id( 'procedure4', 'p' ) is not null
	drop procedure procedure4;
go


create procedure procedure4
	@values valuelist readonly
as
	select *
	from t1
	where c1 in(
		select value
		from @values );


declare @values valuelist;	-- ユーザ定義テーブル型の変数を宣言
insert into @values( value )
values( 1 ), ( 2 ), ( 3 );	-- 変数にデータを格納
execute procedure4 @values;	-- ストアドプロシージャを実行
go
