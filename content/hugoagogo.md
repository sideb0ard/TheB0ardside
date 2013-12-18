---
Title: "Hugo A Go-Go"
Description: "a look into static site generators"
Tags: ["static","markdown","software","web"]
Date: "2013-11-30"
Categories:
  - "blog"
Slug: "hugoagogo"
---
<p><img src="http://www.internationalhero.co.uk/h/hugoagogo.jpg"></p>

Seems like there is quite a move towards more simple blogging platforms, with a number of static site generators all popping up, building upon the simplicity and growing popularity of [Markdown](http://en.wikipedia.org/wiki/Markdown), a stripped back text-to-HTML syntax, and touting the lack of a needed database. These site generators work usually via uploading or editing the markdown files and have a pre-processor convert the markdown to static html files, alongside some form of templating system. The benefits of such simplicity are the ease of backups, being file based, there is no need for database dumps - standard tools are perfect; and secondly, speed - there is very little overheard for the webserver to serve and cache, without the need to hit the DB on each call.

I was previously running a hosted Wordpress installation on Dreamhost, and it was fine, it was easy and it was running; However, it would slow down sometimes to the point of unusability, and well, I wanted to play with something new!

I decided to spin up an AWS instance and play with some of the static site generators out there.

There were a number turned up on my initial search - [Jekyll](http://jekyllrb.com/), [Ghost](https://ghost.org/), [Dropplets](http://dropplets.com/), [Pelican](http://docs.getpelican.com/en/3.3.0/).

Dropplets was the first I looked at - it has a nice clean site, quotes a "30 seconds installation", and has all the buzzwords. After downloading it however, i discovered it was written in PHP. next!

I've been doing a lot of Javascript lately, so **Ghost** sounded pretty good. However, I had problems with some of the required node libraries, specifically the sqlite library - i faffed around for a while trying to build from source, but after 30mins I figured a static site generator should not be this hard to install, so moved on.

Next up i tried **Pelican** (( I must admit, as a Systems Engineer, i feel slightly embarrassed by not being more fluent in Python - I was a Perl guy for many years, and since moving on from there, Ruby has been my lingua franca, mostly due to how essential it is for Chef/Puppet. )). Pelican was up and running pretty quickly, no troubles with the install or running. I left that running for a day or two, but didn't really get around to styling it or finishing it up.

A day or so later, however, I discovered [Hugo](http://hugo.spf13.com/) - which just suddenly seemed like the obvious choice. I've been playing around with GoLang, and although you don't need to actually program anything to get it running, i still liked the idea of using Go. In the end that's the one I've went with for redoing the site - the documentation is really good, and the speed of the Hugo server seems awesome. So - there it is! Now a Hugo A Go-Go powered site!

p.s.
Heres [the script](https://gist.github.com/sideb0ard/7728607) I used for importing a text dump from a Wordpress export to Markdown files.
