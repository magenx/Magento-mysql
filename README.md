magento-mysql
-------------

Magento default mysql settings
==============================

>default/startup settings for mysql database.<br/>
>please read this before changing anything!

    GENERAL OPTIONS

1. **max_connections**<br/>
 *How many connections to allow. Watch* **max_used_connections** *value*

2. **thread_cache**<br/>
 *Cache to prevent excessive thread creation*<br/>
 *50-100 is good value. Watch* **threads_created**<br/>

3. **table_cache/table_open_cache**<br/>
 *Cache of opened table instances*<br/>
 *Single table may have multiple entries*<br/>
 *Watch* **opened_tables** *status value*<br/>
 *Start with 4096*<br/>

4. **open_files_limit**<br/>
 *MyISAM tables require up to 2 file handlers*<br/> 
 *Each connection is file handler too*<br/>
 *Safe to set to 65535 in most systems*<br/>

5. **table_definition_cache**<br/>
 *Cache table definitions (CREATE TABLE)*<br/>
 *Only one entry  per table*<br/>
 *Watch* **Opened_table_definitions**<br/>
 *Set to number of tables + 10% unless 50K+ tables*<br/>

6. **back_log**<br/>
 *Need adjustment if many connections/sec*<br/>
 *2048 is reasonable value*<br/>

7. **max_allowed_packet**<br/>
 *Limits maximum size of query*<br/> 
 *Limits internal string variable size*<br/> 
 *16MB is a good value*<br/>

8. **max_connect_errors**<br/>
 *Prevent password brute force attack*<br/>
 *Can cause "Host Blocked" error messages*<br/>
 *Value around 1000000 is good*<br/>

9. **skip_name_resolve**<br/>
 *Avoid DNS lookup on connection. Faster and Safer*<br/>
 *Do not use host names in GRANTs*<br/>

10. **old_passwords**<br/>
 *Should NOT be enabled. Will cause insecure password hash to be used.*<br/>

11. **log_bin**<br/>
 *Enable for replication and point in time recovery*<br/>
 *Set to mysql-bin to avoid default naming*<br/>

12. **sync_binlog**<br/>
 *Make Binlog durable.  Set to 1 if have RAID with BBU or Flash*<br/>
 *Can be really performance killer with slow drives.*<br/>

13. **expire_log_days**<br/>
 *Purge old binary logs after this number of days*<br/>
 *14 (2 weeks) is a good value with weekly backups*<br/>

14. **tmp_table_size**<br/>
15. **max_heap_table_size**<br/>
 *Typically set to same value (workload based)*<br/>
 **Created_tmp_disk_tables** *status variable*<br/> 
 *Beware BLOB/TEXT fields cause on disk table with any size.*<br/>

16. **query_cache_size**<br/>
 *Enable query cache only if it is tested to provide significant gains*<br/>
 *Often causes stalls and contention*<br/>
 *Do not set over 512M*<br/>

17. **sort_buffer_size**<br/>
 *In memory buffer used for sorting*<br/>
 *Watch* **sort_merge_passes**<br/>
 *Consider setting for session for large queries*<br/>
 *Values up to 1MB are good default*<br/>
 *Large values hurt performance of small queries*<br/>

18. **join_buffer_size**<br/>
 *Helps performance of Joins with no indexes*<br/>
 *Better get rid of such Joins*<br/> 
 *8MB can be reasonable value*<br/>

19. **default_storage_engine**<br/>
 *Use Innodb engine for tables if not specified*<br/>

20. **read_rnd_buffer_size**<br/>
 *Buffer for reading rows in sorted offer*<br/>
 *Specifies Maximum Value*<br/>
 *Values around 16MB often make sense*<br/>
 *Do not mix with* **read_buffer_size**<br/>

21. **Tmpdir**<br/>
 *Specify location of temporary directory*<br/>
 *Tmpfs often good choice unless very large temporary space is needed.*<br/>
 *tmpdir=/dev/shm*<br/>

		MyISAM OPTIONS

1. **key_buffer_size**<br/>
 *Cache MyISAM Indexes.*<br/> 
 *Does Not cache data.*<br/>
 *Up to 30% of memory if using MyISAM only*<br/>

2. **myisam_recover**<br/>
 *Automatically repair corrupted MyISAM tables after crash.* **BACKUP,FORCE** *is a good value.*<br/>

3. **myisam_sort_buffer_size**<br/>
 *Buffer used for building MyISAM indexes by Sort. 8MB-256MB are good values*<br/>

4. **low_priority_updates**<br/>
 *Allow higher concurrency for SELECTs*<br/>
 *May starve update queries*<br/>

5. **bulk_insert_buffer_size**<br/>
 *Buffer to optimize Bulk Inserts*<br/>
 *Values of 1/4 of* **key_buffer_size** *make sense*<br/>
 *Note it is per connection value*<br/>

		INNODB MEMORY SETTINGS

1. **innodb_buffer_pool_size**<br/>
 *The most important setting. Often 80%+ of memory is allocated here.*<br/>

2. **innodb_buffer_pool_instances**<br/>
 *Reduce contention.  Set to 4+ in MySQL 5.5+*<br/>

3. **innodb_log_buffer_size**<br/>
 *Buffer for log files.  Good Values 4MB-128MB*<br/>
 *Not only reduce writes but help contention*<br/> 

4. **innodb_ibuf_max_size**<br/>
 *Control size of Insert buffer. Default is 1/2 of Buffer pool. Smaller values are good for SSD*<br/>

		INNODB IO OPTIONS

1. **innodb_flush_log_at_trx_commit**<br/>
 *Control Durability*<br/>
 *1=flush and sync;  2=flush;  0=neither*<br/>

2. **Innodb_flush_method**<br/>
 *Controls how Innodb Performs IO*<br/>
 **O_DIRECT** *good value for most servers*<br/>

3. **innodb_auto_lru_dump**<br/>
 *Percona Server Feature to warmup quickly*<br/>
 *300 (seconds) is a good value*<br/>

4. **innodb_io_capacity**<br/>
 *Controls Innodb Assumption about Disk Performance. Increase for faster drives*<br/>

4. **innodb_read_io_threads**<br/>
5. **innodb_write_io_threads**<br/>
 *Control number of threads doing reads and writes*<br/>
 *MySQL 5.5 has async IO so very high values might not be needed*<br/>
 *4 is good default. Higher for large IO systems.*<br/>

6. **innodb_flush_neighbor_pages**<br/>
 *Percona Server feature to control how flushing works*<br/>
 *Disable (set to 0) for SSD*<br/>

		OTHER INNODB OPTIONS

1. **innodb_log_file_size**<br/>
 *Size of redo log file. Larger logs better performance but longer recovery.*<br/> 

2. **innodb_log_files_in_group**<br/>
 *Leave at 2 which is default.*<br/>

3. **innodb_file_per_table**<br/>
 *Store each Innodb table in separate file. Usually Good choice*<br/>

4. **innodb=force**<br/>
 *Enable so MySQL does not start if Innodb could not initialize.*<br/> 
 *Otherwise it might start but error on access to all Innodb tables.*<br/>

5. **innodb_lock_wait_timeout**<br/>
 *How long to wait for row level locks before bailing out*<br/>

6. **innodb_old_blocks_time**<br/>
 *Helps to make buffer pool scan resistant*<br/>
 *Values around 1000 make sense*<br/>

7. **innodb_file_format**<br/>
 *Which file format Innodb will use*<br/>
 *Antelope is default legacy format*<br/>
 *Barracuda allows to use new features like compression*<br/>

8. **innodb_stats_on_metadata**<br/>
 *Update statistics on meta data access*<br/>
 *Such as Information_schema queries*<br/>
 *Typically best disabled for more workloads Set to 0*<br/>
 *Innodb will still refresh stats when table changes significantly*<br/>

9. **performance_schema**<br/>
 *Enable Performance Schema in MySQL 5.5+*<br/>
 *Watch potential overhead.*<br/> 

10. **log_slow_queries**<br/>
 *Enable Slow Query Log. Old but very helpful.*<br/>

11. **long_query_time**<br/>
 *Especially with* **long_query_time** *set to 0 periodically to get sample of the load*<br/>

12. **log_slow_verbosity=full**<br/>
 *Get a lot more data about queries in Percona Server*<br/>

13. **low_warnings=2**<br/>
 *Get warnings about disconnects and other minor issues in error log.*<br/>
 *More information but it can get spammy*<br/>

14. **userstat_running=1**<br/>
 *Get advanced Table and Index usage statistics in Percona Server and MariaDB*<br/>