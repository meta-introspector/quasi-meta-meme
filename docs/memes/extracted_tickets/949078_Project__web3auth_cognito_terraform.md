# Project : web3auth cognito terraform

**ID:** 949078
**Created At:** 2025-01-16T15:39:10+00:00
**Source:** https://codeberg.org/introspector/SOLFUNMEME/issues/5

---

Construct a plan For the SOLFUNMEME project and its customers and holders we want to 
provide free tier web hosting  (or as cheap as possible) for one or more nextjs sites

Using LLMs and ai agents to help us. Creating bounties denoted in ZOS1 NFTS and SOLFUNMEME. 

Following this guide
https://web3auth.io/docs/guides/cognito

Modify this terraform branch 
https://github.com/meta-introspector/ai-agent-terraform/tree/feature/codebuild

to renable cognito (it was setup before)

Cloning this repo
https://github.com/Web3Auth/web3auth-pnp-examples/tree/main/web-no-modal-sdk%2Fcustom-authentication%2Fsingle-verifier-examples%2Fcognito-no-modal-example

and then we will setup route53/cloudflare dns for 
https://solfunmeme.introspector.meme

create aws https certificate for domain 

Integrate this terraform for the static hosting 
https://github.com/milliHQ/terraform-aws-next-js
and or vercel 
https://vercel.com/guides/integrating-terraform-with-vercel
and or cloudflare in front of s3

Bonus points for github app login as well, see my other repos on github jmikedupont2/meta-introspector for github app examples.(fixme with links)