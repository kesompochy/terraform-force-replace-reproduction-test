```sh
$ terraform apply
# Insert source data
$ bq query --use_legacy_sql=false 'INSERT INTO my_dataset.source_table (time) VALUES (CURRENT_TIMESTAMP())' 
$ bq query --replace --use_legacy_sql=false --destination_table=my_dataset.test_table 'SELECT time AS time FROM my_dataset.source_table'
Waiting on bqjob_r3f95ae4e67f52d74_00000191f78135af_1 ... (1s) Current status: DONE
+---------------------+
|        time         |
+---------------------+
| 2024-09-16 06:57:34 |
+---------------------+
$ bq query --replace --use_legacy_sql=false --destination_table=my_dataset.test_table 'SELECT time AS TIME FROM my_dataset.source_table'
Waiting on bqjob_r4c9ceead521c2858_00000191f780dca2_1 ... (2s) Current status: DONE
+---------------------+
|        time         |
+---------------------+
| 2024-09-16 06:57:34 |
+---------------------+
$ vim main.tf # Uncomment out to import
$ terraform apply # import test_table
$ 
$ vim main.tf # comment out the import block
$ terraform init
$ terraform apply # create dataset in your project
# create the table with uppercase field manually
$ vim modules/bigquery/table.tf # revert comment out
$ vim main.tf # revert comment out to import the table resource
$ terraform init
$ terraform plan # the plan shows the forces replacement
```
