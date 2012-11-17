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
## MyISAM tables require up to 2 file handlers 
## Each connection is file handler too
## Safe to set to 65535 in most systems

+ **table_definition_cache**<br/>
## Cache table definitions (CREATE TABLE)
## Only one entry  per table 
## Watch Opened_table_definitions
## Set to number of tables + 10% unless 50K+ tables

+ **back_log**<br/>
## Need adjustment if many connections/sec 
## 2048 is reasonable value

+ **max_allowed_packet**<br/>
## Limits maximum size of query 
## Limits internal string variable size 
## 16MB is a good value

+ **max_connect_errors**<br/>
## Prevent password brute force attack
## Can cause "Host Blocked" error messages
## Value around 1000000 is good

+ **skip_name_resolve**<br/>
## Avoid DNS lookup on connection. Faster and Safer
## Do not use host names in GRANTs

+ **old_passwords**<br/>
## Should NOT be enabled. Will cause insecure password hash to be used.

+ **log_bin**<br/>
## Enable for replication and point in time recovery
## Set to mysql-bin to avoid default naming

+ **sync_binlog**<br/>
## Make Binlog durable.  Set to 1 if have RAID with BBU or Flash
## Can be really performance killer with slow drives.

+ **expire_log_days**<br/>
## Purge old binary logs after this number of days
## 14 (2 weeks) is a good value with weekly backups

+ **tmp_table_size**<br/>
+ **max_heap_table_size**<br/>
## Typically set to same value (workload based)
## Created_tmp_disk_tables status variable 
## Beware BLOB/TEXT fields cause on disk table with any size.

+ **query_cache_size**<br/>
## Enable query cache only if it is tested to provide significant gains
## Often causes stalls and contention
## Do not set over 512M

+ **sort_buffer_size**<br/>
## In memory buffer used for sorting
## Watch sort_merge_passes
## Consider setting for session for large queries
## Values up to 1MB are good default
## Large values hurt performance of small queries

+ **join_buffer_size**<br/>
## Helps performance of Joins with no indexes
## Better get rid of such Joins ! 
## 8MB can be reasonable value

+ **default_storage_engine**<br/>
## Use Innodb engine for tables if not specified

+ **read_rnd_buffer_size**<br/>
## Buffer for reading rows in sorted offer
## Specifies Maximum Value
## Values around 16MB often make sense
## Do not mix with read_buffer_size 

+ **Tmpdir**<br/>
## Specify location of temporary directory
## Tmpfs often good choice unless very large temporary space is needed.
## tmpdir=/dev/shm

################################################################################
########################    MyISAM options    ##################################
################################################################################
+ **key_buffer_size**<br/>
## Cache MyISAM Indexes. 
## Does Not cache data.
## Up to 30% of memory if using MyISAM only

+ **myisam_recover**<br/>
## Automatically repair corrupted MyISAM tables after crash.  BACKUP,FORCE is a good value.

+ **myisam_sort_buffer_size**<br/>
## Buffer used for building MyISAM indexes by Sort.   8MB-256MB are good values

+ **low_priority_updates**<br/>
## Allow higher concurrency for SELECTs
## May starve update queries

+ **bulk_insert_buffer_size**<br/>
## Buffer to optimize Bulk Inserts
## Values of 1/4 of key_buffer_size make sense
## Note it is per connection value

################################################################################
##########################    Innodb Memory Settings    ########################
################################################################################ 
+ **innodb_buffer_pool_size**<br/>
## The most important setting. Often 80%+ of memory is allocated here. 

+ **innodb_buffer_pool_instances**<br/>
## Reduce contention.  Set to 4+ in MySQL 5.5+

+ **innodb_log_buffer_size**<br/>
## Buffer for log files.  Good Values 4MB-128MB
## Not only reduce writes but help contention 

+ **innodb_ibuf_max_size**<br/>
## Control size of Insert buffer.  Default is 1/2 of Buffer pool. Smaller values are good for SSD

################################################################################
##########################    Innodb IO Options    #############################
################################################################################
+ **innodb_flush_log_at_trx_commit**<br/>
## Control Durability
## 1=flush and sync;  2=flush;  0=neither

+ **Innodb_flush_method**<br/>
## Controls how Innodb Performs IO
## O_DIRECT good value for most servers 

+ **innodb_auto_lru_dump**<br/>
## Percona Server Feature to warmup quickly
## 300 (seconds) is a good value

+ **innodb_io_capacity**<br/>
## Controls Innodb Assumption about Disk Performance. Increase for faster drives

+ **innodb_read_io_threads**<br/>
+ **innodb_write_io_threads**<br/>
## Control number of threads doing reads and writes
## MySQL 5.5 has async IO so very high values might not be needed
## 4 is good default. Higher for large IO systems.

+ **innodb_flush_neighbor_pages**<br/>
## Percona Server feature to control how flushing works
## Disable (set to 0) for SSD

#################################################################################
#######################    Other Innodb Options    ##############################
#################################################################################
+ **innodb_log_file_size**<br/>
## Size of redo log file. Larger logs better performance but longer recovery. 

+ **innodb_log_files_in_group**<br/>
## Leave at 2 which is default.

+ **innodb_file_per_table**<br/>
## Store each Innodb table in separate file. Usually Good choice

+ **innodb=force**<br/>
## Enable so MySQL does not start if Innodb could not initialize. Otherwise it might start but error on 
## access to all Innodb tables.

+ **innodb_lock_wait_timeout**<br/>
## How long to wait for row level locks before bailing out

+ **innodb_old_blocks_time**<br/>
## Helps to make buffer pool scan resistant
## Values around 1000 make sense

+ **innodb_file_format**<br/>
## Which file format Innodb will use 
## Antelope is default legacy format
## Barracuda allows to use new features like compression 

+ **innodb_stats_on_metadata**<br/>
## Update statistics on meta data access
## Such as Information_schema queries
## Typically best disabled for more workloads Set to 0
## Innodb will still refresh stats when table changes significantly

+ **performance_schema**<br/>
## Enable Performance Schema in MySQL 5.5+
## Watch potential overhead. 

+ **log_slow_queries**<br/>
## Enable Slow Query Log. Old but very helpful.

+ **long_query_time**<br/>
## Especially with long_query_time set to 0 periodically to get sample of the load

+ **log_slow_verbosity=full**<br/>
## Get a lot more data about queries in Percona Server

+ **low_warnings=2**<br/>
## Get warnings about disconnects and other minor issues in error log. 
## More information but it can get spammy

+ **userstat_running=1**<br/>
## Get advanced Table and Index usage statistics in Percona Server and MariaDB