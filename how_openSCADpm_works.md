# How openSCADpm works (and why it works the way it does).

## Intro
openSCADpm provides the functionality of NPM for Node.js or Gems for Ruby. While a tutorial exists for how to use openSCADpm this document serves to explain how openSCADpm provides that functionality. There are several parts to this:

1. How openSCADpm interacts with GitHub

2. How openSCADpm interacts wtih with the user.

3. How openSCADpm interacts with the openSCAD library system.

## Interactions with GitHub

Given the popularity of GitHub as a platform to host open-source (and closed-source) software we found a tight integration with the platform has _several advantages_:

* GitHub is easy to browse.
  * It allows topical tags.
  * Open access to repositories.
* GitHub is free. 
  * Hosting funding is a non-issue.
  * More people can contribute this way.
  * openSCADpm can continue to exist without continuos funding.
* GitHub has a built in system for making releases.
  * This provides a standardized method.
  * Releases can be easily browsed.
  * Releases can be easily created and documented.
* Easy and reliable downloads.
* Trusted source for downloads.

Thus we felt rather the reinventing the wheel and bearing  the cost for a less reliable, less trustworthy hosting system openSCADpm would use Github for hosting. Briefly here are the ways openSCADpm uses GitHub:

* Packages are hosted on GitHub.
  * This is enforced by the CLI using a specialized git clone that only downloads from GitHub.
  * Releases are done using [GitHub releases](https://help.github.com/articles/about-releases/), so as to keep them easily browsable and easy to do.
* Packages are found through GitHub.
  * GitHub has a great tag system and instead making authors do the work of adding tags in a website and on GitHub we opted to use strictly GitHub instead. 
  * The website for the package manager has links to common tags and a simplifying search feature for topic tags. The goal of these is to encourage tag usage by authors and to help consumers to search via these topical tags.
* For the same reasons that openSCADpm packages are hosted on GitHub so is the actual tool 
* Indeed given the free hosting features of GitHub the [website](https://skp2140.github.io/openSCADpm/) is also hosted by GitHub. 

## Interaction with the user and and their local environment.

The CLI of openSCADpm is built in Bash 3. There were three main reasons for doing this:

* Portability.
* Limited dependencies.
  * Compared to requiring the user to have a particular programming language and packages for that language installed.
* Fast(er) development time.
  * Bash's main purpose if file-system manipulation and that fits the needs of openSCADpm.
 
 The CLI tool is designed so that users can:
1.  Add it to the path. 
2.  Make it an executable.
3.  Be able to use it from anywhere as a normal command line tool. 

This is done like any other executable and instructions can be found in the tutorial.

Alternatively, as it is a bash script openSCADpm can be called in any way a bash script can be.

## Interactions with the openSCAD library system.

