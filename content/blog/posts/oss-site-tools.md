+++
date = "2017-10-05T09:00:00-07:00"
draft = false
title = "Open source tools leveraged in this site"
categories = ["resources"]
tags = ["tools", "publishing", "opensource"]
author = "Ram Gopinathan" 
 
+++
# Overview

In this post I wanted to walkthrough how the T-Mobile opensource site is setup and cover the tools and content publishing process we are leveraging. If you are looking to begin your journey towards opensource hopefully this information will be useful.

## Our Requirements

When we first started talking with [Steve](http://insert-link-to-steves-profile) and [Tim](http://insert-link-to-tims-profile) about launching our opensource site to show case lot of the great work our teams are doing, both Steve and Tim wanted to make sure we leveraged opensource tools and not rely on any internal tools or processes. Additionally we needed to make sure a light weight governance process exist before content becomes public. Any new content created get's reviewed by OSS working group for things like correctness, authenticity, follows guidelines on content classification etc.

## Tools

Here is the list of tools we ended up leveraging.

### Hugo

Content for this site is statically generated using an opensource tool called [hugo](http://gohugo.io) created by [Steve Francia](http://spf13.com/) who works on the golang team at Google. If you are content author and will be creating content for this opensource site, first thing you will need to install on your laptop is hugo. 
If you are using HomeBrew installing Hugo is easy, simply run the command below

``` bash
brew install hugo
```

If you are new to Hugo, please check out this [QuickStart Guide](http://gohugo.io/overview/quickstart/)

### Github

All the content that you see in this site is stored in a Github [repository](http://github.com/tmobile/opensource). Repository has two branches, "master" branch reflects all content currently public and accessible through opensource.t-mobile.com site and "develop" branch reflects all content currently public and any new content that is under development or review and accessible via opensource.corporate.t-mobile.com. Since the site is generated using Hugo, Hugo creates a folder called "content" to organize all content used in the site. We are also using the same site to host technical articles under "blog" section. You simply use Hugo commands to create content for respective sections of this site. All content is stored as [markdown](https://en.wikipedia.org/wiki/Markdown) files. Again please be sure to check out the [QuickStart Guide](http://gohugo.io/overview/quickstart/) if you are new to Hugo.

### Travis-CI

For continuous integration; publishing in this usecase to be exact we are using a service called [Travis-CI](http://travis-ci.com)

### AWS S3

Static HTML pages generated using Hugo are stored in an S3 bucket. Content for internal site (opensource.corporate.t-mobile.com) external site (opensource.t-mobile.com) are stored in seperate S3 buckets to insolate content that is under draft/under development v/s content that is live and accessible through external site.

### AWS Cloudfront

For global content delivery we are leveraging cloudfront service. When new content is published we are using a custom [script](https://raw.githubusercontent.com/tmobile/opensource/master/cdn-invalidate.sh) to invalidate the cloudfront distribution.

### AWS Route 53

DNS URLs for both internal and external opensource sites are managed using AWS Route 53 service, Hosted zone and record set maps the internal and external site URLs to cloud front endpoints

## Contributing content

Its super simple to contribute content to this site, only requirement is to be familiar with github, hugo and other tools mentioned earlier. New content is first published to internal instance of this site. Content reviewers will review the new content and if everything looks good they'll approve, after which changes are live in publicly accessible instance of this site.

### Internal Site

As mentioned earlier all content for internal instance of this site are generated from "develop" branch. At this point we are only accepting PRs from internal users as well as select folks from external community. When changes are merged to "develop" branch, builds run in Travis-CI which will generate site content using Hugo CLI and pushes the generated content into a folder within a S3 bucket using Travis-CI S3 deployment provider. After content is successfully pushed to S3 we run a custom script to invalidate the cloudfront distribution. You can see this from the [.travis.yml](https://raw.githubusercontent.com/tmobile/opensource/develop/.travis.yml) below for develop branch.

![devbuild](/blog/devbuild.png)

### External Site

Master branch in the repository is protected so that nobody is allowed to push changes directly to it without a pull request and review. Our OSS site maintainers will review each PRs, All PRs must have atleast one approved reviewer and no changes requested to be eligible for merge into master branch. 
Once the changes submitted via PR are merged to master branch, Travis-CI builds will build the content from master branch and publish to S3. Publishing steps in build script are pretty identical to what's described for develop branch, only difference is content is push to a different S3 bucket. Additionally when site content is generated using Hugo CLI, any content in draft state is skipped. You can see this from the [.travis.yml](https://raw.githubusercontent.com/tmobile/opensource/master/.travis.yml) below for master branch.

![masterbuild](/blog/masterbuild.png)

Hope you found this helpful.

Cheers,

Ram Gopinathan