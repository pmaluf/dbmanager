# dbmanager

Script to deploy DB instances using the Direct NFS(dNFS) CloneDB feature

## Notice

This script was tested in:

* Linux
  * OS Distribution: Red Hat Enterprise Linux Server release 6.4 (Santiago)
* Oracle 
  * 11gR2

## Prerequisities

* Enable the dNFS 
  * [White Paper Oracle Database 11g Direct NFS Client](http://www.oracle.com/technetwork/articles/directnfsclient-11gr1-twp-129785.pdf)

## How to use it

```
# dbmanager.sh
# Created: Paulo Victor Maluf - 5/2015
#
# Parameters:
#
#   dbmanager.sh --help
#
#    Parameter             Short Description                                                        Default
#    --------------------- ----- ------------------------------------------------------------------ --------------
#    --master-sid             -m SID of database with will be cloned
#    --clone-sid              -c SID of the new instance
#    --drop-database          -d Delete the database
#    --list-databases         -l List the active databases
#    --skip-recover           -s Skip recover database before open resetlogs                        FALSE
#    --help                   -h help
#
#   Ex.: dbmanager.sh --master-sid BRM1 --clone-sid BRM2
#        dbmanager.sh --drop-database BRM2
```


Example:

* Clone the master database SGA to SGA2
```
./dbmanager --master-sid SGA --clone-sid SGA2
[28052015 08:53:03] Setting enviroment variables... [ OK ]
[28052015 08:53:03] Creating clone dir(/nfs_rw/SGA2)... [ OK ]
[28052015 08:53:03] Executing clone.pl... [ OK ]
[28052015 08:53:03] Starting instance SGA2... [\]   [ OK ]
[28052015 08:53:09] Executing the clonedb_renamefile... [\]   [ OK ]
[28052015 08:53:12] Cataloging archivelogs from /ro/archive/SGA... [ OK ]
[28052015 08:53:14] Gettting the SCN for a consistent recovery...
[28052015 08:53:14] Recovering database, please wait this may take a few hours... [\]   [ OK ]
[28052015 08:53:17] Open database resetlogs... [-]   [ OK ]
[28052015 08:55:07] Creating spfile... [ OK ]
[28052015 08:55:07] Creating oenv entry... [ OK ]
```

* List all CloneDBs
```
./dbmanager --list-databases
BRM1  [ OK ]
BRM2  [ OK ]
SGA1  [ OK ]
SGA2  [ OK ]
```

* Drop the CloneDB SGA2
```
./dbmanager --drop-database SGA2
[28052015 08:55:41] Shutting down the SGA2... [|]   [ OK ]
[28052015 08:55:49] Deleting datafiles... [|]   [ OK ]
[28052015 08:55:49] Deleting configfiles... [ OK ]

./dbmanager -l
BRM1  [ OK ]
BRM2  [ OK ]
SGA1  [ OK ]
```

## License

This project is licensed under the MIT License - see the [License.md](License.md) file for details
