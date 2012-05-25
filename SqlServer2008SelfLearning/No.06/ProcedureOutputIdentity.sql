/*
	ストアドプロシージャ
	出力パラメータ
*/
use Test;

if object_id( 't2', 'u' ) is not null
	drop table t2;

if object_id( 'procedure6', 'p' ) is not null
	drop procedure procedure6;
go


-- テストデータ作成
create table t2(
	c1 int identity( 1, 1 ),
	c2 int );

insert into t2( c2 ) values( 111 );
insert into t2( c2 ) values( 222 );

select * from t2;
select scope_identity();
go


create procedure procedure6
	@param1 int,
	@param2 int output
as
	insert into t2( c2 ) values( 333 )
	select @param2 = scope_identity();


declare @result int;
execute procedure6 333, @result output;
select @result;
go