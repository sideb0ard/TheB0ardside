---
Title: "Troubleshooting the JVM at Twitter"
Description: "twitter tools for profiling java performance"
Tags: ["performance","video","java","jvm","twitter"]
Date: "2013-12-09"
Categories:
  - "blog"
Slug: "troubleshootingjvmtwitter"
---

This talk is incredibly informative - Twitter have their own fork of OpenJDK, in which they have enabled registers on the CPU, normally used by the Java Compiler - this enables Frame Pointers which [perf](https://perf.wiki.kernel.org/index.php/Main_Page) can read and translate, enabling a full Stack trace from JVM bytecode right down into the kernel. 

Beyond simply CPU counters and stack trace, they also tie in other JVM flags which export DTrace counters, and use these to construct connections between memory allocation and the running process, so in the end you have a tool which can spans JVM -> kernel connections, alongside CPU -> memory.

Sounds very useful, i look forward to them open-sourcing it..

<div class="video-container">
<iframe width="560" height="315" src="//www.youtube.com/embed/Yg6_ulhwLw0?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

