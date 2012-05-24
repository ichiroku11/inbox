/*
	cteによる再帰クエリとhierarchyidデータ型
*/
use Test;


if object_id( 'employee', 'u' ) is not null
	drop table employee;

create table employee(
	no int not null,
	name nvarchar( 40 ),
	boss_no int,	-- 上司社員番号
	gender nchar( 4 ) );

insert into employee values( 1001, N'山田太郎', null, N'男性' );
insert into employee values( 1002, N'鈴木一郎', null, N'男性' );
insert into employee values( 1003, N'岡田花子', 1001, N'女性' );
insert into employee values( 1004, N'渡辺花美', 1002, N'女性' );
insert into employee values( 1005, N'佐藤次郎', 1001, N'男性' );
insert into employee values( 1006, N'川崎太郎', 1003, N'男性' );

select *
from employee;


-- ある上司の部下一覧を取得
with cte( no, name, boss_no, gender, level )
as(
	-- 上司
	select employee.*, 0
	from employee
	where no = 1001

	union all

	-- 部下( 再帰 )
	select employee.*, cte.level + 1
	from employee
		inner join cte on employee.boss_no = cte.no )
select *
from cte;


-- 階層パスも表示
with cte( path, no, name, boss_no, gender, level )
as(
	-- 上司
	select
		hierarchyid::GetRoot(),
		employee.*,
		0
	from employee
	where no = 1001

	union all

	select
		cast( cte.path.ToString() + cast( employee.no as varchar( 30 ) ) + '/' as hierarchyid ),
		employee.*,
		cte.level + 1
	from employee
		inner join cte on employee.boss_no = cte.no )
select path.ToString(), *
from cte;
