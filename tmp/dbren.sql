WHENEVER SQLERROR EXIT SQL.SQLCODE;
declare 
begin 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-AGGREGATE_TS_1_DAT_FNO-11_0vqcmrni' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM10.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-AGGREGATE_TS_1_IDX_FNO-12_10qcmrno' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM11.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-INTEGRATE_TS_1_DAT_FNO-13_11qcmro4' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM12.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-INTEGRATE_TS_1_IDX_FNO-14_12qcmrol' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM13.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-INTEGRATE_TS_2_DAT_FNO-15_13qcmrs8' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM14.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-INTEGRATE_TS_2_IDX_FNO-16_14qcmru1' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM15.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-INTEGRATE_TS_3_DAT_FNO-17_15qcmruf' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM16.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-INTEGRATE_TS_3_IDX_FNO-18_16qcmrv4' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM17.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-INTEGRATE_TS_4_DAT_FNO-19_17qcmrvh' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM18.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-INTEGRATE_TS_4_IDX_FNO-20_18qcms0i' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM19.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-JSA_TS_1_DAT_FNO-9_0tqcmrgu' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM110.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-JSA_TS_1_IDX_FNO-10_0uqcmrh4' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM111.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-PIN00_FNO-6_0pqcmrgn' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM112.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-PINTEMP_FNO-8_0sqcmrgq' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM113.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-PINX00_FNO-7_0qqcmrgn' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM114.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-SYSAUX_FNO-2_1eqcmsaa' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM115.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-SYSTEM_FNO-1_1dqcms7e' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM116.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-TSD_DBTOOLS01_FNO-23_1bqcms6r' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM117.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-TSD_PAR_FNO-21_19qcms55' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM118.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-TSI_DBTOOLS01_FNO-24_1cqcms6t' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM119.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-TSI_PAR_FNO-22_1aqcms5n' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM120.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-TSTOOLS01_FNO-5_0rqcmrgo' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM121.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-UNDOTBS1_FNO-3_1fqcmsag' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM122.dbf'); 
dbms_dnfs.clonedb_renamefile('/nfs_hanoi_ro/TIBRM/data_D-TIBRMC_I-93544382_TS-USERS_FNO-4_1gqcmsbu' , '/nfs_hanoi_rw/TIBRM1/ora_data_TIBRM123.dbf'); 
end; 
/ 
show errors; 
exit; 
