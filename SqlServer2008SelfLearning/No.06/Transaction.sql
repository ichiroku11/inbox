/*
	transactionとtry/catch
*/
use Test;


if object_id( 't3', 'u' ) is not null
	drop table t3;

create table t3(
	c1 int primary key,
	c2 int );


begin try
	begin transaction
		insert into t3 values( 1, 999 );
		insert into t3 values( 1, 999 );
	commit transaction;
end try
begin catch
	-- 制約違反エラーではロールバックが発生しないので手動でロールバック
	rollback transaction;
	select
		error_number(),		-- エラー番号
		error_message(),	-- エラーメッセージ
		error_severity(),	-- エラーの重大度レベル
		error_state(),		-- エラーの状態番号
		error_line(),		-- エラーが発生した行番号
		error_procedure();	-- エラーが発生したストアドプロシージャまたはトリガの名前
	raiserror( 'エラーのテスト!', 16, 1 );
end catch
