/*
	フルバックアップ、差分バックアップ、ログバックアップのリストア
*/

use master;


-- フルバックアップをリストア
restore database Test
from disk = N'D:\Database\Backup\Test.full.bak'
with replace,
	norecovery;	-- 復旧中

use Test;	-- データベース 'Test' を開けません。復元中です。


-- 差分バックアップをリストア
restore database Test
from disk = N'D:\Database\Backup\Test.diff.bak'
with norecovery;	-- 復旧中


-- ログバックアップをリストア
restore log Test
from disk = N'D:\Database\Backup\Test.log2.bak'
with recovery;	-- 復旧完了( 省略してもいい )


use Test;
select * from t1;
