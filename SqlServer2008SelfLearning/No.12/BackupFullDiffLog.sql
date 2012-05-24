/*
	フルバックアップ、差分バックアップ、ログバックアップ
*/


-- テスト用のテーブルの初期化
use Test;
if object_id( 't1', 'u' ) is not null
	drop table t1;
create table t1( c1 int );
insert into t1( c1 ) values( 1 );
select * from t1;


-- フルバックアップ
backup database Test
to disk = N'D:\Database\Backup\Test.full.bak'
with format;


-- 1件追加してログバックアップ
insert into t1( c1 ) values( 2 );
select * from t1;

backup log Test
to disk = N'D:\Database\Backup\Test.log1.bak'
with format;


-- 1件追加して差分バックアップ
insert into t1( c1 ) values( 3 );
select * from t1;

backup database Test
to disk = N'D:\Database\Backup\Test.diff.bak'
with format, differential;


-- 1追加してログバックアップ
insert into t1( c1 ) values( 4 );
select * from t1;

backup log Test
to disk = N'D:\Database\Backup\Test.log2.bak'
with format;


delete from t1;
select * from t1;

use master;

