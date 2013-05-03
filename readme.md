Website Reachability Check Shell Script
=======================================

Shell script to check the reachability of a website.
It executes a ping and traceroute which helps to determine
whether it's a network issue.
It verifies the status code in the response header of the website.


The script depends on
---------------------
* ping
* traceroute
* curl

Usage
-----
Edit the shell script and configure the websites to be checked in the
variable `WEBSITES`. Each site goes into one line.

Execute it:

    $ ./website-reachability-check.sh | tee logfile.txt
    google__80: 
    google__80: Fri May  3 19:29:03 CEST 2013
    google__80: Host    : www.google.de
    google__80: Port    : 80
    google__80: Prot    : http
    google__80: Path    : index.html
    google__80: Ping to www.google.de:
    google__80:   PING www.google.de (173.194.69.94) 56(84) bytes of data.
    google__80:   64 bytes from bk-in-f94.1e100.net (173.194.69.94): icmp_req=1 ttl=63 time=30.5 ms
    google__80:   64 bytes from bk-in-f94.1e100.net (173.194.69.94): icmp_req=2 ttl=63 time=31.6 ms
    google__80:   64 bytes from bk-in-f94.1e100.net (173.194.69.94): icmp_req=3 ttl=63 time=30.9 ms
    google__80:   64 bytes from bk-in-f94.1e100.net (173.194.69.94): icmp_req=4 ttl=63 time=31.0 ms
    google__80:   --- www.google.de ping statistics ---
    google__80:   4 packets transmitted, 4 received, 0% packet loss, time 3011ms
    google__80:   rtt min/avg/max/mdev = 30.517/31.050/31.646/0.402 ms
    google__80: Traceroute to www.google.de:
    google__80:   traceroute to www.google.de (173.194.69.94), 30 hops max, 60 byte packets
    google__80:    1  * * *
    google__80:    2  fritz.fonwlan.box (192.168.178.1)  2.861 ms  3.301 ms  3.682 ms
    google__80:    5  inxs.google.com (194.59.190.61)  41.518 ms  44.293 ms  45.233 ms
    google__80:    6  66.249.94.86 (66.249.94.86)  247.868 ms 66.249.94.88 (66.249.94.88)  298.617 ms  301.201 ms
    google__80:    7  216.239.48.127 (216.239.48.127)  73.058 ms 216.239.48.119 (216.239.48.119)  40.412 ms  40.653 ms
    google__80:    8  64.233.174.53 (64.233.174.53)  41.448 ms 216.239.48.53 (216.239.48.53)  41.159 ms 64.233.174.55 (64.233.174.55)  36.332 ms
    google__80:    9  * * *
    google__80:   10  bk-in-f94.1e100.net (173.194.69.94)  30.622 ms  29.984 ms  29.168 ms
    google__80: HTTP Header for http://www.google.de:80/index.html:
    google__80:   HTTP/1.1 200 OK
    google__80:   Date: Fri, 03 May 2013 17:29:47 GMT
    google__80:   Expires: -1
    google__80:   Cache-Control: private, max-age=0
    google__80:   Content-Type: text/html; charset=ISO-8859-1
    google__80:   Server: gws
    google__80:   X-XSS-Protection: 1; mode=block
    google__80:   X-Frame-Options: SAMEORIGIN
    google__80:   Transfer-Encoding: chunked
    google__80:   
    google__80: Test PASSED.
    ...

Check for any failures:

    $ grep "Test FAILED" logfile.txt

Check for passed tests:

    $ grep "Test PASSED" logfile.txt
    google__80: Test PASSED.
    google_443: Test PASSED.

License
-------
    Copyright (C) 2013 Andreas Dangel <adangel at users.sourceforge.net>
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

