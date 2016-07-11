# clonedb.pl - This script generates two sql scripts that can be used to
# create your test clones. Run this from your testdb Oracle Home env
#
# Before running this script make sure the following env variables are set:
#
# MASTER_COPY_DIR - env variable to point to the directory where the
#                   backup/snapshot of your Master database are kept
#
# CLONE_FILE_CREATE_DEST - env variable to point to the directory where
#                          clonedb files will be created including datafiles,
#                          log files, control files
#
# CLONEDB_NAME  - Cloned database name
#
# S7000_TARGET - Set if the nfs host providing the filesystem for the backup
#                and the clones is an S7000 series machine and we wish to
#                employ its cloning features.
#
# perl clonedb.pl <master_db.ora> <crtdb.sql> <dbren.sql>
#
# Arg1 - Full path of the Master db init.ora file from your production env
# Arg2 - sqlscript1
# Arg3 - sqlscript2
#
# This script copies the init.ora file from your master db env to your
# clonedb  env in CLONE_FILE_CREATE_DEST directory.
#
# After running this script go through the test database parameter file to
# make sure all parameters look correct
#
# Go through crtdb.sql to make sure the log names are correct.
# If all files look good do the following steps
#
# sqlplus system/manager
# @crtdb.sql
# @dbren.sql
#
# Now your test database should be available for use.
#

if ($#ARGV != 2) {
 print "usage: perl clonedb.pl <master_init.ora> <crtdb.sql> <dbren.sql> \n";
 exit 1;
}

if (!$ENV{'MASTER_COPY_DIR'}) {
 print "MASTER_COPY_DIR env not set. Set this and rerun it again \n";
 exit;
}

if (!$ENV{'CLONE_FILE_CREATE_DEST'}) {
 print "CLONE_FILE_CREATE_DEST env not set. Set this and rerun it again \n";
 exit;
}

if (!$ENV{'CLONEDB_NAME'}) {
 print "CLONEDB_NAME env not set. Set this and rerun it again \n";
 exit;
}

($orafile)=$ARGV[0];
($sqlfile1)=$ARGV[1];
($sqlfile2)=$ARGV[2];

# Set env variable specific to your clone database
$neworafile ="$ENV{'CLONE_FILE_CREATE_DEST'}/init$ENV{'CLONEDB_NAME'}.ora";
$cldboh = "$ENV{'ORACLE_HOME'}";
$cldbosid = "$ENV{'ORACLE_SID'}";
$cldbname = "$ENV{'CLONEDB_NAME'}";
$cldbctlfl = "$ENV{'CLONE_FILE_CREATE_DEST'}/$ENV{'CLONEDB_NAME'}_ctl.dbf";
$mastercopydir = "$ENV{'MASTER_COPY_DIR'}";
$clonedbdir ="$ENV{'CLONE_FILE_CREATE_DEST'}";
$s7000 = $ENV{S7000_TARGET} ? 1 : 0 ;

# Check if the CLONE_FILE_CREATE_DEST exists
if (! open(CLONEDIR, $clonedbdir))
{
  print("CLONE_FILE_CREATE_DEST directory does not exist.\n");
  print("Create this directory and rerun the script \n");
  exit;
}
close(CLONEDIR);

# Rename the parameters in the copied production init.ora and will open a new init.ora with new values
open (INFILE,$orafile);
open (OUTFILE,">$neworafile");
@skipparam=("instance_name","service_names","diagnostic_dest");
@inparam=("db_name","control_files");
@outparm=($cldbname,$cldbctlfl);
$skiplen = @skipparam;
$inlen = @inparam;

for $ln (<INFILE>)
{
  $newln = $ln;

#look for any include files and read their contents
  if ($newln =~ "ifile")
  {
    @lnsp = split("=",$newln);
    open(INCFILE, $lnsp[1]);
    print OUTFILE "# Copy from $lnsp[1] \n";

    for $ln (<INCFILE>)
    {
      $newln = $ln;
      for ($i=0; $i<$skiplen; $i++){
        if ($newln =~ /$skipparam[$i]/)
        {
          $newln="\n";
        }
      }

      for ($i=0; $i<$inlen; $i++){
        if ($newln =~ /$inparam[$i]/)
        {
          @lnsp = split("=",$newln);
          $lnsp[1]=$outparm[$i];
          $newln=$inparam[$i]."=".$lnsp[1]."\n";
        }
      }
      print OUTFILE "$newln";
    }
    close INCFILE;
    print OUTFILE "# End Copy";
  }
  else
  {

    for ($i=0; $i<$skiplen; $i++){
      if ($newln =~ /$skipparam[$i]/)
      {
        $newln="\n";
      }
    }

    for ($i=0; $i<$inlen; $i++){
      if ($newln =~ /$inparam[$i]/)
      {
        @lnsp = split("=",$newln);
        $lnsp[1]=$outparm[$i];
        $newln=$inparam[$i]."=".$lnsp[1]."\n";
      }
    }
    print OUTFILE "$newln";
  }
}

# Add db_create_file_dest, log_arhive_dest parameter
print OUTFILE "db_create_file_dest=$clonedbdir\n";
print OUTFILE "log_archive_dest=$clonedbdir\n";
#print OUTFILE "clonedb=TRUE\n";

close INFILE;
close OUTFILE;

# Create clone db raneame file sql
if (!$s7000)
{
  $target=$mastercopydir;
} else {
  $target=$clonedbdir;
}

# XXX Needs to be modified to just deal with datafiles.
system ("cd $target; ls -d $target/* >> /tmp/dnfsa1axxx.log");
system ("cp /tmp/dnfsa1axxx.log .;rm /tmp/dnfsa1axxx.log");
open(INPFILE,"dnfsa1axxx.log");
open(INTFILE,">filenamexxx.txt");
open(OUTFILE1,">$sqlfile2");
open(OUTFILE,">dnfsa2axxx.log");

for $ln (<INPFILE>)
{
       print INTFILE "$ln";
}
close INTFILE;
close INPFILE;

open(INTFILE,"filenamexxx.txt");
$refline=" ";
for $line (<INTFILE>)
{
  $line =~ s/\s+$//;
  if ($refline ne " ")
  {
   print OUTFILE  "'"."$refline"."'".", \n";
  }
  $refline = $line;
}
if ($refline ne " ")
{
 print OUTFILE  "'"."$refline"."' \n";
}
close INTFILE;

if (!$s7000)
{
  print OUTFILE1 "WHENEVER SQLERROR EXIT SQL.SQLCODE;\n";
  print OUTFILE1 "declare \n";
  print OUTFILE1 "begin \n";
  open(INTFILE,"filenamexxx.txt");
  $i = 0;
  for $lne (<INTFILE>)
  {
    $lne =~ s/\s+$//;
    print OUTFILE1 "dbms_dnfs.clonedb_renamefile('$lne' , '$clonedbdir/\ora_data_$cldbname$i.dbf'); \n";

    $i++;
  }
  print OUTFILE1 "end; \n";
  print OUTFILE1 "/ \n";
  print OUTFILE1 "show errors; \n";
  print OUTFILE1 "exit; \n";
}

#print OUTFILE1 "alter database open resetlogs;\n";

#Add a default temp tablespace in teh clone env
#print OUTFILE1 "CREATE TEMPORARY TABLESPACE TEMP2;\n";
#print OUTFILE1 "ALTER DATABASE DEFAULT TEMPORARY TABLESPACE TEMP2;\n";
#print OUTFILE1 "DROP TABLESPACE TEMP;\n";
#print OUTFILE1 "ALTER TABLESPACE TEMP2 RENAME TO TEMP;\n";
#print OUTFILE1 "drop tablespace TEMP;\n";
#print OUTFILE1 "create temporary tablespace TEMP;";

close OUTFILE;
close OUTFILE1;
close OUTFILE1;
close OUTFILE1;

# Create the create controlfile script
open(INPFILE1,"dnfsa2axxx.log");
open(INPSQLFILE,">interm.sql");
open (OUTSQLFILE,">$sqlfile1");
print INPSQLFILE ("
SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100

WHENEVER SQLERROR EXIT SQL.SQLCODE

STARTUP NOMOUNT PFILE=$neworafile
CREATE CONTROLFILE REUSE SET DATABASE $cldbname RESETLOGS
    MAXLOGFILES 32
    MAXLOGMEMBERS 2
    MAXDATAFILES 300
    MAXINSTANCES 1
    MAXLOGHISTORY 908
LOGFILE
  GROUP 1 '$clonedbdir/$cldbname\_log1.log' SIZE 512M BLOCKSIZE 512,
  GROUP 2 '$clonedbdir/$cldbname\_log2.log' SIZE 512M BLOCKSIZE 512
DATAFILE
CHARACTER SET UTF8; 
exit ; ");
close INPSQLFILE;

open(INPSQLFILE,"interm.sql");
for $ln (<INPSQLFILE>)
{
   print OUTSQLFILE "$ln";
   if ($ln =~ /^DATAFILE/)
   {
     for $ln0 (<INPFILE1>)
        {
        print OUTSQLFILE "$ln0";
        }
   }
}

close OUTSQLFILE;
close INPFILE1;
close INPSQLFILE;

unlink("interm.sql");
unlink("dnfsa1axxx.log");
unlink("dnfsa2axxx.log");
unlink("filenamexxx.txt");


