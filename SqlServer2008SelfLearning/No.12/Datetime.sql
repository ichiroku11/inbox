/*
	バックアップファイル名に日付
*/

-- 年月日を含むファイル名を作成する
declare @date datetime = getdate();
declare @ymd char( 8 ) = convert( char( 8 ), @date, 112 );	-- yymmdd
declare @hms char( 6 ) = replace( convert( char( 8 ), @date, 108 ), ':', '' );	-- hh:mm:ss -> hhmmss
declare @file nvarchar( max ) = N'D:\Database\Backup\Test.' + @ymd + @hms + '.bak';
select @ymd, @hms, @file;


-- バックアップ
use Test;
backup database Test
to disk = @file;


