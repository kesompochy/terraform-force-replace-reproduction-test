```sh
$ vim modules/bigquery/table.tf # comment out the resource in table.tf
$ vim main.tf # comment out the import block
$ terraform init
$ terraform apply # create dataset in your project
# create the table with uppercase field manually
$ vim modules/bigquery/table.tf # revert comment out
$ vim main.tf # revert comment out to import the table resource
$ terraform init
$ terraform plan # the plan shows the forces replacement
```

It shows the forces replacement, but it did not yesterday...
