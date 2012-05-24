/*
	バックアップとリストアの基本
*/


-- テスト用のテーブルを作成
use Test;
if object_id( 't1', 'u' ) is not null
	drop table t1;
create table t1( c1 int );
insert into t1( c1 ) values( 1 ), ( 2 ), ( 3 ), ( 4 );
select * from t1;


-- バックアップファイル
declare @file nvarchar( max ) = N'D:\Database\Backup\Test.bak';

-- バックアップ
use master;
backup database Test to disk = @file
with name = N'ここに名前',
	description = N'ここに説明',
	format,			-- バックアップファイルをフォーマット( 設定しないとファイル内に複数のバックアップセットができる )
	compression;	-- バックアップ圧縮( バックアップ、リストア時間を短縮できる )


-- バックアップしたバックアップセットを確認
restore headeronly
from disk = @file;


-- データを削除
use Test;
delete from t1;
select * from t1;


-- リストア
use master;
restore database Test
from disk = @file
with replace;	-- 既存のDBを上書き


-- リストアしたDBを確認
use Test;
select * from t1;

