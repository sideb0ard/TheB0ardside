---
Title: "building a DEB package from a perl script"
Description: "building a DEB package from a perl script"
Tags: ["configuration management","debian","perl","unix"]
Date: "2012-02-16"
Categories:
  - "blog"
Slug: "buildingadebpackagefromaperlscript"
---

<p>I have a speedtest perl script i wrote - nothing complicated, takes a file and uploads it to a remote FTP or SFTP server, while calculating how long, then gives you a a measure of the MB/per second bandwidth between two sites.</p><p>I want it available on a selection of machines so it can run from wherever, so I thought i'd package it up as a .DEB file and stick it in our local repo. Nothing complicated in that, and there are a <a href="http://www.debian-administration.org/articles/336" target="_blank">number</a> of <a href="http://www.debian-administration.org/articles/337" target="_blank">online</a> <a href="http://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics.en.html" target="_blank">tutorials</a> about building your own debs. The main drawback with most I found was that they assume you are actually building from source rather than just distributing a script, although I also found <a href="http://askubuntu.com/questions/27715/create-a-deb-package-from-scripts-or-binaries" target="_blank">a relevant Ubuntu thread</a> which is pretty simple and to the point.</p><p>However, even using these tutorials it still took me a few hours to figure out. There are just a couple of non-obvious points, so i figure writing out my own steps is worth recording -</p><p>So first, grab your required packages:</p><p><strong><code>apt-get install dh-make dpkg-dev debhelper devscripts fakeroot lintian</code></strong></p><p>You will need to build from a directory with the name of your script in the form <code>packagename-version</code>, so for mine i created <strong>/tmp/speedtest-1.0</strong>, then copied in my script &#8216;<strong>speedtest</strong>&#8216; and it's data file <strong>25MBFLAC.file</strong> ( which i could have created with <strong>dd</strong> on the box rather than copy over, but downloading the file is actually quicker in this situation ).</p><p>The first step is to run:</p><p><strong><code>dh_make -s --indep --createorig -e thor@valhalla.com</code></strong><br />(dash-s means create a single binary .deb - i.e. no source version; indep means architecture-independent; and createorig is to indicate you are the original maintainer)</p><p>this creates a top-level &#8216;<strong>debian</strong>&#8216; directory containing all the necessary config files.<br />The main one you need to edit is <strong>debian/control</strong> - you prob only need fill in &#8220;section&#8221;, &#8220;homepage&#8221; and &#8220;Description&#8221;</p><p>Mine looks like:</p><p><code>Source: speedtest<br />Section: web<br />Priority: extra<br />Maintainer: Thorsten Sideboard &lt;thor@valhalla.com&gt;<br />Build-Depends: debhelper (>= 7.0.50~)<br />Standards-Version: 3.8.4<br />Homepage: http://github.com/sideboard/speedtest.git</p><p>Package: speedtest<br />Architecture: all<br />Depends: ${misc:Depends}<br />Description: Test Upload Speeds<br /></code></p><p>One of the things which baffled me for a while, which was answered in the <a href="http://askubuntu.com/questions/27715/create-a-deb-package-from-scripts-or-binaries" target="_blank">askubuntu link above</a>, was how to specify where something is installed &#8212; it goes in a file &#8216;<strong>debian/install</strong>&#8216; which isn't created for you. The format of the file is &#8216;<strong>filename location/to/be/installed</strong>&#8221; (without the initial slash)</p><p>so in my case, i ran:<br /><code>echo "speedtest usr/local/Scriptz/" > debian/install<br />echo "25MBFLAC.file usr/local/Scriptz/" >> debian/install<br /></code></p><p>At this point, you should then be able to run:<br /><code>debuild -us -uc</code></p><p>and you <em>should</em> have a deb file built. but..</p><p>First i ran into :</p><p><code>dpkg-source: error: can&#039;t build with source format &#039;3.0 (quilt)&#039;: no orig.tar file found</code></p><p>As the above-mentioned askubuntu post says, you can </p><p><code>echo "1.0" > debian/source/format</code></p><p>then re-running the <code>debuild -us -uc</code> i ran into </p><p><code>dpkg-source: error: cannot represent change to speedtemp-1.0/25MBFLAC.file: binary file contents changed</code></p><p>This error is due to leftover build-cruft from my last run - if you check the directory one step up from where you are, you'll see debuild has already built some files for you, typically a tar.gz, a .dsc and a .build file. Delete all them, then re-run <code>debuild -us -uc</code> &#8212; now it should build properly!</p><p>ah! </p><p><code>dh_usrlocal: debian/speedtemp/usr/local/Scriptz/speedtest is not a directory</code></p><p>This one also caught me out for a while - turns out this is caused by my specifying &#8220;/usr/local/Scriptz&#8221; as my install location - </p><blockquote><p>Most third-party software installs itself in the /usr/local directory hierarchy. On Debian this is reserved for private use by the system administrator, so packages must not use directories such as /usr/local/bin but should instead use system directories such as /usr/bin, obeying the Filesystem Hierarchy Standard (FHS).</p></blockquote><p> (from <a href="http://www.debian.org/doc/manuals/maint-guide/modify.en.html#destdir" target="_blank">here</a>)</p><p>So, yeah, i changed my <strong>debian/install</strong> file to be &#8220;<strong>speedtest usr/bin</strong>&#8221;</p><p>and finally! running <code>debuild -us -uc</code> completes properly, outputting a <strong>/tmp/speedtest_1.0-1_all.deb</strong> which can then be installed via<br /><strong><code>dpkg -i /tmp/speedtest_1.0-1_all.deb </code></strong></p><p>One last note &#8212; there are four useful scripts to also know about &#8212; <strong><code>preinst, postinst, prerm, postrm</code></strong> &#8212; these should be in the <code>debian/</code> directory - pretty self-explanatory - pre- and post- install and remove scripts - if these exist, they will be run exactly as they are named, so for example, i wanted my 25MBFLAC.file still to be installed under /usr/local/Scriptz, so i listed it to be installed in the debian/install file as &#8220;25MBFLAC.file tmp&#8221; and then in my postinst file, i added:</p><p><code>#!/bin/sh<br />mv /tmp/25MBFLAC.file /usr/local/Scriptz/<br /></code></p>
