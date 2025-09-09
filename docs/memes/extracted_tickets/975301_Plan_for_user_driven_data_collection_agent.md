# Plan for user driven data collection agent

**ID:** 975301
**Created At:** 2025-02-08T13:09:28+00:00
**Source:** https://codeberg.org/introspector/SOLFUNMEME/issues/118

---

Users will be able to collect private intelligence data for training sovereign agents
by pointing their browser  and apps (and recruiting helper)
at our wireguard vpn (or equivalent), 

So basically use the vpn, browse websites, we collect that data,
you review it with your self hosted ai on private on prem servers (eg ollama )
and serve results with public llms (open ai, groq) with extracted cleared information that can exposed.

You will have your private llm, and public llm, and two layers of data. 

using man in the middle proxy
mitmproxy https://mitmproxy.org/ 

The urls collected can be scraped further via a web spider like
https://www.yacy.net/

The data collect can be stored on your 30gb free tier server
and also permanently via s3 buckets on aws.

There are more options we will provide, like ipfs storage.


