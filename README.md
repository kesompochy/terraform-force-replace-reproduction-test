```sh
$ terraform apply
# Insert source data
$ bq query --use_legacy_sql=false 'INSERT INTO my_dataset.source_table (time) VALUES (CURRENT_TIMESTAMP())' 
# Create a test table from source table
$ bq query --replace --use_legacy_sql=false --destination_table=my_dataset.test_table 'SELECT time AS time FROM my_dataset.source_table'
Waiting on bqjob_r3f95ae4e67f52d74_00000191f78135af_1 ... (1s) Current status: DONE
+---------------------+
|        time         |
+---------------------+
| 2024-09-16 06:57:34 |
+---------------------+
# The field case will not be changed when `bq query --replace` is executed. 
$ bq query --replace --use_legacy_sql=false --destination_table=my_dataset.test_table 'SELECT time AS TIME FROM my_dataset.source_table'
Waiting on bqjob_r4c9ceead521c2858_00000191f780dca2_1 ... (2s) Current status: DONE
+---------------------+
|        time         |
+---------------------+
| 2024-09-16 06:57:34 |
+---------------------+
$ vim main.tf # Uncomment out to import
$ terraform apply # import test_table

$ bq query --replace --use_legacy_sql=false --destination_table=my_dataset.test_table 'SELECT time AS TIME FROM my_dataset.source_table'
Waiting on bqjob_r1f93302c0bb154bd_00000191f780049b_1 ... (1s) Current status: DONE
+---------------------+
|        time         |
+---------------------+
| 2024-09-16 06:57:34 |
+---------------------+
$ vim main.tf # change attributes not related to the schema, such as `deletion_protection` for example
$ terraform apply
# The schema case will be changed when `bq query --replace` is executed
$ bq query --replace --use_legacy_sql=false --destination_table=my_dataset.test_table 'SELECT time AS TIME FROM my_dataset.source_table'
Waiting on bqjob_r4eca9f9d94559614_00000191f77f8929_1 ... (1s) Current status: DONE
+---------------------+
|        TIME         |
+---------------------+
| 2024-09-16 06:57:34 |
+---------------------+
$ terraform plan # shows force replace
```
