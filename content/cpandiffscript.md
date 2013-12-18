---
Title: "CPAN Diff script"
Description: "CPAN Diff script"
Tags: ["configuration management","perl","programming","unix"]
Date: "2011-12-16"
Categories:
  - "blog"
Slug: "cpandiffscript"
---
<p><img src="http://theslowbullet.files.wordpress.com/2011/01/clonecover.jpg" alt="diff" /></p><p>I put together a quick perl script for comparing installed CPAN modules between two hosts. Find it <a href="https://github.com/sideb0ard/CPANDiff" title="CPANDiff" target="_blank">here</a>.</p><p>Quite easy to use:<br />Usage: ./CompareHostCpanModules.pl login@host1 login@host2</p><p>The script ssh's into both hosts (so it's easier if you have your ssh-keys setup) and grabs a list of installed CPAN modules and versions, then outputs the differences - it returns two lists - one of modules installed but having different versions, and another list of modules missing from the second host. </p>
