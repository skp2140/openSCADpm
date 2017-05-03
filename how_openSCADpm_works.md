# How openSCADpm works.

## Intro
openSCADpm provides the functionality of NPM for Node.js or Gems for Ruby. While a tutorial exists for how to use openSCADpm this document serves to explain how openSCADpm provides that functionality. There are several parts to this:

1. How openSCADpm interacts with GitHub

2. How openSCADpm interacts wtih with the user.

3. How openSCADpm interacts with the openSCAD library system.

## Interactions with GitHub

Given the populaitry of GitHub as a platform to host opensource (and closed-source) software we found a tight integration with the platform has _several advantages_:

* GitHub is easy to browse.
  * It allows topical tags.
  * Open access to repoistories.
* GitHub is free. 
  * Hosting funding is a non-issue.
  * More people can contribute this way.
  * openSCADpm can continue to exist without coninous funding.
* GitHub has a built in system for making releases.
  * This provides a standardized method.
  * Releases can be easily browsed.
  * Releases can be easily created and documented.
* Easy and realiable downloads.
* Trusted source for downloads.

Thus we felt rather the revineting the wheel and bearing  the cost for a less realiable, less trustworthy hosting system openSCADpm would use Github for hosting. Briefly here are the ways openSCADpm uses GitHub:

* Packages are hosted on GitHub.
  * This is enforced by the CLI using a specalized git clone that only downloads from GitHub.
  * Releases are done using [GitHub releases](https://help.github.com/articles/about-releases/), so as to keep them easily browsable and easy to do.
* Packages are found through GitHub.
  * GitHub has a great tag system and instead making authors do the work of adding tags in a website and on GitHub we opted to use strictly GitHub instead. 
  * The website for the package manager has links to common tags and a simplifying search feature for topic tags. The goal of these is to encourage tag usage by authors and to help consumers to search via these topical tags.
* For the same reasons that openSCADpm packages are hosted on GitHub so is the actual tool 
* Indeed given the free hosting features of GitHub the [website](https://skp2140.github.io/openSCADpm/) is also hosted by GitHub.

 

## Interaction withh with the user and and thier local enviorment.

## Interactions with the openSCAD library system.

