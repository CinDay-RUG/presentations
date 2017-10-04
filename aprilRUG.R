# Using packages with type = "source" works on Windows provided the package contains no C/C++/Fortran code that needs compilation. 
# Otherwise you will need to have installed the Rtools collection as described in the ‘R for Windows FAQ’ and you must have the PATH set up as required by Rtools. 

# http://www.murdoch-sutherland.com/Rtools/

# You need to have installed 'C Include Files / Lib Files' when installing the MySQL binary distribution.

# Then just set MYSQL_HOME to point to the top of the MySQL installation and install via Rcmd INSTALL in the usual way.

install.packages(c("RMySQL_0.7-5.tar.gz"), repos = NULL, type="source")
install.packages(c("RMySQL"), repos = NULL, type='source')

install.packages(
    c("XML_0.99-5.tar.gz",
      "../../Interfaces/Perl/RSPerl_0.8-0.tar.gz"),
    repos = NULL,
    configure.args = c(XML = '--with-xml-config=xml-config',
                       RSPerl = "--with-modules='IO Fcntl'"))




install.packages('RMySQL',type='source')

install.packages('DBI')

install.packages('RJDBC')

install.packages('RSQLite')



> install.packages('RMySQL', type = 'source') 
trying URL 'http://cran.case.edu/src/contrib/RMySQL_0.7-5.tar.gz'
Content type 'application/x-gzip' length 160769 bytes (157 Kb)
opened URL
downloaded 157 Kb

* installing *source* package 'RMySQL' ...
checking for $MYSQL_HOME... C:/PROGRA~1/MySQL55
cygwin warning:
  MS-DOS style path detected: C:/PROGRA~1/MySQL55
  Preferred POSIX equivalent is: /cygdrive/c/PROGRA~1/MySQL55
  CYGWIN environment variable option "nodosfilewarning" turns off this warning.
  Consult the user's guide for more details about POSIX paths:
    http://cygwin.com/cygwin-ug-net/using.html#using-pathnames
** libs
Warning: this package has a non-empty 'configure.win' file,
so building only the main architecture

cygwin warning:
  MS-DOS style path detected: C:/Users/stu/R2121/etc/x64/Makeconf
  Preferred POSIX equivalent is: /cygdrive/c/Users/stu/R2121/etc/x64/Makeconf
  CYGWIN environment variable option "nodosfilewarning" turns off this warning.
  Consult the user's guide for more details about POSIX paths:
    http://cygwin.com/cygwin-ug-net/using.html#using-pathnames
x86_64-w64-mingw32-gcc -I"C:/Users/stu/R2121/include" -I"C:/PROGRA~1/MySQL55"/include        -O2 -Wall  -std=gnu99 -c RS-DBI.c -o RS-DBI.o
x86_64-w64-mingw32-gcc -I"C:/Users/stu/R2121/include" -I"C:/PROGRA~1/MySQL55"/include        -O2 -Wall  -std=gnu99 -c RS-MySQL.c -o RS-MySQL.o
x86_64-w64-mingw32-gcc -shared -s -static-libgcc -o RMySQL.dll tmp.def RS-DBI.o RS-MySQL.o C:/PROGRA~1/MySQL55/bin/libmySQL.dll -LC:/Users/stu/R2121/bin/x64 -lR
x86_64-w64-mingw32-gcc.exe: C:/PROGRA~1/MySQL55/bin/libmySQL.dll: No such file or directory
ERROR: compilation failed for package 'RMySQL'
* removing 'C:/Users/stu/R2121/library/RMySQL'

The downloaded packages are in
        ‘C:\Users\stu\AppData\Local\Temp\RtmpYJFfAb\downloaded_packages’
Warning messages:
1: running command 'C:\Users\stu\R2121/bin/x64/R CMD INSTALL -l "C:/Users/stu/R2121/library"   C:\Users\stu\AppData\Local\Temp\RtmpYJFfAb/downloaded_packages/RMySQL_0.7-5.tar.gz' had status 1 
2: In install.packages("RMySQL", type = "source") :
  installation of package 'RMySQL' had non-zero exit status
> install.packages('RMySQL', type = 'source') 
trying URL 'http://cran.case.edu/src/contrib/RMySQL_0.7-5.tar.gz'
Content type 'application/x-gzip' length 160769 bytes (157 Kb)
opened URL
downloaded 157 Kb

* installing *source* package 'RMySQL' ...
checking for $MYSQL_HOME... C:/PROGRA~1/MySQL55
cygwin warning:
  MS-DOS style path detected: C:/PROGRA~1/MySQL55
  Preferred POSIX equivalent is: /cygdrive/c/PROGRA~1/MySQL55
  CYGWIN environment variable option "nodosfilewarning" turns off this warning.
  Consult the user's guide for more details about POSIX paths:
    http://cygwin.com/cygwin-ug-net/using.html#using-pathnames
** libs
Warning: this package has a non-empty 'configure.win' file,
so building only the main architecture

cygwin warning:
  MS-DOS style path detected: C:/Users/stu/R2121/etc/x64/Makeconf
  Preferred POSIX equivalent is: /cygdrive/c/Users/stu/R2121/etc/x64/Makeconf
  CYGWIN environment variable option "nodosfilewarning" turns off this warning.
  Consult the user's guide for more details about POSIX paths:
    http://cygwin.com/cygwin-ug-net/using.html#using-pathnames
x86_64-w64-mingw32-gcc -I"C:/Users/stu/R2121/include" -I"C:/PROGRA~1/MySQL55"/include        -O2 -Wall  -std=gnu99 -c RS-DBI.c -o RS-DBI.o
x86_64-w64-mingw32-gcc -I"C:/Users/stu/R2121/include" -I"C:/PROGRA~1/MySQL55"/include        -O2 -Wall  -std=gnu99 -c RS-MySQL.c -o RS-MySQL.o
x86_64-w64-mingw32-gcc -shared -s -static-libgcc -o RMySQL.dll tmp.def RS-DBI.o RS-MySQL.o C:/PROGRA~1/MySQL55/bin/libmySQL.dll -LC:/Users/stu/R2121/bin/x64 -lR
installing to C:/Users/stu/R2121/library/RMySQL/libs/x64
** R
** inst
** preparing package for lazy loading
Warning: package 'DBI' was built under R version 2.12.2
Creating a new generic function for "format" in "RMySQL"
Creating a new generic function for "print" in "RMySQL"
** help
*** installing help indices
** building package indices ...
** testing if installed package can be loaded

* DONE (RMySQL)

The downloaded packages are in
        ‘C:\Users\stu\AppData\Local\Temp\RtmpYJFfAb\downloaded_packages’
> 

drv = dbDriver("MySQL")
con = dbConnect(drv, user="s133cs", dbname="BaseballDataBank", host="statdocs.berkeley.edu")
dbListTables(con)
dbReadTable(con, "Allstar", row.names = "PlayerID")
dbGetQuery(con,"SELECT COUNT(*) FROM Allstar;")
rs = dbSendQuery(con2, "SELECT * FROM TCPConnections;")
firstBatch = fetch(rs, n = 500)
secondBatch = fetch(rs, n = 200)
dbHasCompleted(rs)
dbClearResult(rs)


# Demo Database Features
library(RODBC)
con <- odbcConnect("testdb", uid="root", pwd="agsllc11", case="tolower")

## tell it to map names to l/case
> channel <- odbcConnect("testdb", uid="ripley", case="tolower")
drv = dbDriver("ODBC")


con <- odbcConnect(uid="root", case="tolower")

# show mysql driver connect
library(RMySQL)
drv = dbDriver("MySQL")
con = dbConnect(drv, user="root", dbname="testdb", password="agsllc11")

