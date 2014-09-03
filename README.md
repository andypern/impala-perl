#Impala perl

##pre-req's



###Cluster
	
Install HIVE (version is important!):

	clush -a 'yum install -y mapr-hive-0.12.26671-1'

Put hivemetastore somewhere:

	yum install -y 	mapr-hivemetastore-0.12.26671
	
Install impala:

	clush -a 'yum install -y mapr-impala-server'
	
Install statestore & catalog server somewhere:

	yum install -y mapr-impala-statestore mapr-impala-catalog
	

Make sure hive metastore works, and that impala-shell works like normal


###Client

On your client (can be a cluster node if you like)

1. First install gcc

		yum install -y gcc
	
2.  Install unixODBC

	
		yum install -y unixODBC-devel.x86_64
	
3. Install cpan

		yum install -y cpan

4.  Run clan to initialize the wizard

		cpan

> (follow wizard, if it complains about dependancies then deal with those)




5.  Once CPAN is happy, in cpan shell:

		install DBI::DBD
	then
		
		install DBD::ODBC



	 
	 

####MapR Impala ODBC Driver:

Docs are here: http://doc.mapr.com/pages/viewpage.action?pageId=23266350#JDBC/ODBCConnections-ODBCClientConnectionsonLinux


1.  Grab the driver:

		cd /tmp

		wget http://package.mapr.com/tools/MapR-ODBC/MapRImpala_odbc_1.1.1/Linux/EL5/MapRImpalaODBC-1.0.1.1001-1.x86_64.rpm
	
2.  Install
	
		rpm -ivh MapRImpalaODBC-1.0.1.1001-1.x86_64.rpm
	

3.  Set your library path and some other variables (you might want to put into .bashrc)

		export LD_LIBRARY_PATH=/usr/local/lib:/opt/mapr/impalaodbc/lib/64
	

		export ODBCINI=/etc/odbc.ini
	
		export ODBCSYSINI=/usr/local/odbc
	
		export SIMBAINI=/etc/mapr.impalaodbc.ini
		
>note: these override the default locations.  You're more than welcome to use the default locations which are listed in the previously mentioned documentation if you like..but you'll need to make sure to pay attention to which files you are editing.
	
	
4.  Copy some template files into place:

	
		cp /opt/mapr/impalaodbc/Setup/odbc.ini /etc
		
		cp /opt/mapr/impalaodbc/Setup/odbcinst.ini /usr/local/odbc
		
		cp /opt/mapr/impalaodbc/Setup/odbc.ini /etc
		
	

5.  Modify /etc/odbc.ini to look like this:

		[ODBC Data Sources]
		Sample MapR Impala DSN 64=MapR Impala ODBC Driver 64-bit
		
		[Imp64]
		Driver=/opt/mapr/impalaodbc/lib/64/libmaprimpalaodbc64.so
		HOST=node0
		PORT=21050

>note: these are the `user` ODBC data sources.

3.  Modify /usr/local/odbc/odbinst.ini (you can append):

		#MapR ODBC
		[ODBC Drivers]
		MapR Impala ODBC Driver 32-bit=Installed
		MapR Impala ODBC Driver 64-bit=Installed
		 
		[MapR Impala ODBC Driver 32-bit]
		Description= MapR Impala ODBC Driver (32-bit)
		Driver=/opt/mapr/impalaodbc/lib/32/libmaprimpalaodbc32.so
		 
		[MapR Impala ODBC Driver 64-bit]
		Description=MapR Impala ODBC Driver (64-bit)
		Driver=/opt/mapr/impalaodbc/lib/64/libmaprimpalaodbc64.so
		
>note: these are the `system` ODBC sources.  You don't actually need them if you are only going to use the `user` ones defined previously.		
		

4.  Modify /etc/mapr.impalaodbc.ini .  make sure to comment out all ODBC driver managers EXCEPT:
	
		#   SimbaDM / unixODBC
		ODBCInstLib=libodbcinst.so

5.  Modify the perl script in this repo to your liking, and test.



##Appendix

####Cloudera Impala ODBC driver:

Maybe you want to use Cloudera's driver instead.  I haven't tested but here's how to install.

1.  Install some pre-req's:

		yum install -y cyrus-sasl-plain.x86_64
	and:
		
		yum install -y cyrus-sasl-gssapi
	
2.  Grab the cloudera driver:

		cd /tmp
	
		wget https://downloads.cloudera.com/connectors/impala-2.5.15.1015/Linux/EL5/ClouderaImpalaODBC-2.5.15.1015-1.el5.x86_64.rpm
	
	
		 rpm -ivh ClouderaImpalaODBC-2.5.15.1015-1.el5.x86_64.rpm 
	 
	 
	 
###useful commands

	odbcinst -q -d
	odbcinst -q -s
	
	perl -MDBI -e 'DBI-> installed_versions;'
	
	
		
	

	