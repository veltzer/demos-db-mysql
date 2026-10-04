# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `rsconstruct.toml:1` - the repo has `.luacheckrc` and `config/project.lua` but no `[processor.luacheck]`, so nothing lints the Lua config. Add `[processor.luacheck]` with `src_dirs = ["config"]`, as c-xmeltdown does.
- `long/transactions/03_demo_fail_transaction_when_based_on_outofdate_data.sh:46` and `long/transactions/exercise.txt:28` - the demo name and the exercise ("Client 1 commit is rejected") say the stale transaction fails. Under InnoDB's default REPEATABLE READ, client 1's `UPDATE ... where data=15` is a current read: it matches 0 rows and the `COMMIT` succeeds, which is what the script's `SELECT ROW_COUNT()` shows. Reword the title and exercise to "the update based on stale data silently affects 0 rows", or demo a real rejection (`SELECT ... FOR UPDATE` / SERIALIZABLE).

## Low

- `long/number_of_digits_beside_int/README.md:5` - typo `CRATE TABLE`, and the SQL snippet (lines 5-7) is not in a fenced code block, so it renders as running text. Fence it as ```sql and fix the typo.
- `long/transactions/02_demo_outofdate_data_shown_even_after_changed_with_third_client.sh:11` - `${dbname}` is unquoted on lines 11, 13 and 14, while the sibling scripts 01 and 03 quote it. Quote it for consistency.
- `long/transactions/01_demo_outofdate_data_shown_even_after_changed.sh:19` (and 02/03) - the background `mysql` clients are never `wait`ed for before the final `DROP DATABASE`, so their last output can interleave with the cleanup messages. Add `wait` after closing the fds.
- `README.md:7` - `short/*.sql` run through the `#!/usr/bin/env mysql_run.sh` shebang, which comes from utils-bash and is not in this repo. Say so in the README, or the snippets look unrunnable.
- `long/transactions/exercise.txt:29` - typo `exercsies`.
