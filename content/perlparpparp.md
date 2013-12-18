---
Title: "perl parp parp"
Description: "perl parp parp"
Tags: ["howto","internet","networking","TCP/IP","unix"]
Date: "2012-09-02"
Categories:
  - "blog"
Slug: "perlparpparp"
---
<p>I updated the IP address for both my Name Servers tonite, and was monitoring to see how quickly the new addresses were propagating.  First stop was the exceptionally useful <a href="http://www.whatsmydns.net/ " title="What&#039;s My DNS?" target="_blank">Whats My DNS</a></p><p>At the host level I also wanted to track the incoming DNS queries using tcpdump. I could see them streaming into the new host, and visually you could see an obvious difference when viewing the output of the same command on the old host. I googled around for a timer utility which run a command for a given time, so i could quantify the difference. Perfect answer was <a href="http://stackoverflow.com/questions/601543/command-line-command-to-auto-kill-a-command-after-a-certain-amount-of-time" title="Stack Overflow" target="_blank">here</a>, a simple perl wrapper function.</p><p>Here's how to use it to run tcpdump command for sixty seconds, and count the packets seen:</p><p><small><code># doalarm () { perl -e &#039;alarm shift; exec @ARGV&#039; "$@"; }<br /># doalarm 60 tcpdump -u  -i eth0 port 53  -n  |wc -l<br />tcpdump: verbose output suppressed, use -v or -vv for full protocol decode<br />listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes<br />19504</code></small></p>
