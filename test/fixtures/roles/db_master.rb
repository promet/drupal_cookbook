name 'db_master'
description 'master of all dbs'
run_list 'recipe[database::mysql]', 'recipe[database::master]'
