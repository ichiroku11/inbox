/*
	merge
	row_number, rank, dense_rank, ntile
	ページング
*/
use Test;

if object_id( 't2', 'u' ) is not null
	drop table t2;

create table t2(
	c1 int,
	c2 varchar( 3 ) );

insert into t2( c1, c2 )
--values( 1, 'AAA' ), ( 2, 'BBB' ), ( 4, 'CCC' ), ( 9, 'HHH' ), ( 3, 'EEE' ), ( 6, 'BBB' ), ( 7, 'FFF' ), ( 8, 'GGG' ), ( 10, 'III' ), ( 5, 'DDD' );
values( 1, 'AAA' ), ( 2, 'BBB' ), ( 4, 'CCC' ), ( 9, 'HHH' ), ( 6, 'BBB' ), ( 7, 'FFF' ), ( 8, 'GGG' ), ( 10, 'III' ), ( 5, 'DDD' );
go


-- 変数をもとにしたmerge
select * from t2;

declare @c1 int = 3;
declare @c2 varchar( 3 ) = 'EEE';

merge into t2
using( select @c1 as c1, @c2 as c2 ) var	-- マージ対象
	on t2.c1 = var.c1
when matched then		-- 条件がマッチした場合
	update set t2.c2 = var.c2
when not matched then	-- 条件にマッチしなかった場合
	insert values( var.c1, var.c2 );

select * from t2;
go


-- row_number, rank, dense_rank, ntile
select
	row_number() over( order by c2 desc ) as row_number,	-- 単純な行番号( 連番 )
	rank() over( order by c2 desc ) as rank,				-- 同じ値があった場合は同じ順位に( 次の順位を飛ばす )
	dense_rank() over( order by c2 desc ) as dense_rank,	-- 同じ値があった場合は同じ順位に( 次の順位を連続にする )
	ntile( 3 ) over( order by c2 desc ) as ntile,			-- n等分して順位付け
	*
from t2;
-- さらにpartition byでグループ化して順位取得可能
go


-- n件目からm件目の取得( ページング )
select *
from t2
order by c1;

select *
from(
	-- インラインビュー( from区で括弧を付けたselect文の )
	select row_number() over( order by c1 ) as no, *
	from t2 ) as temp
where temp.no between 2 and 5;
go

