# OpenSCADpm

OpenSCAD, a programming used for creating solid 3D CAD models and computer assisted designing. While package
managers have become powerful tools that assist software engineers during their development process, we found
that there are no package managers for OpenSCAD. Thus, OpenSCADpm, this package manager aims to serve OpenSCAD,
akin to Node Package Manager (NPM) or Ruby Gems, which will allow developers to more easily share and install
modules. Furthermore, it will allow users to manage dependencies. 

To this end we create a command line tool and a website. The command line tool will be used for the 
installation and managing of modules by allowing users to use terminal commands. The website will allow users 
to upload packages. It will also serve as a way for packages to be browsed and explained with a high level 
description (this seems to be the norm for package managers).

For more information about OpenSCAD, [Click here](http://www.openscad.org/about.html). 

## Synopsis
The Installation section is just enough infor to get you up and running. 
Much more informaiton available in the Usage section and the documentation file we have in this repo.


## OpenSCADpm Installation
**This version of OpenSCADpm is only for Macs and Linux/Unix**

1. Install the lastest version of OpenSCADpm by visiting the website below and click the "DOWNLOAD OPENSCADPM" link.

```sh
https://skp2140.github.io/openSCADpm/index.html
```

2. A file named ospm will be downloaded.  

3. Open terminal, go to **the folder that contains the "ospm" file **, and enter the following command
```sh
mv ospm /usr/local/bin/
```
This command will move the ospm folder to the location /usr/local/bin/ folder, which allows the users 
to used ospm from anywhere in the system without restriction. 

4. Use the documentation below to find the path to the ospm libaray in your system.
```sh
https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries
```

5. type the following in the terminal
```sh
ospm library save <path-to-ospm-library> 
```

6. You are all set!

## OpenSCADpm Package Installation and Usage

There are two approaches to use ospm for package installing, uninstalling and other options: **User 
Script Approach** and **Package Name Approach**. 


### User Script Approach
You can create a user script (txt file recommended) that contains the dependencies of packages for 
OpenSCAD packages. 

You can read the content of that txt file by th command below.
```sh
cat myList.txt
```
In the txt file, each row should provide the information for the needed package. The first element 
should be the author name, the second element should be the package name, and the last element 
should be the package version number. Furthermore, in this example, since ospm_hello depends on 
echo function, so the information for ospm_hello is one row above the information for echo. 

```sh
<author name> <package name> <package version number>
brennangw ospm_hello 0.4
brennangw echo 0.1
```

Once you have the user script ready, type the following command in the terminal, inside the folder
that contains the myList.txt.

```sh
ospm install list myList.txt
```

This command will help you to download what's specified in txt file. 


### Package Name Approach

You can also download package by using the command below.
```sh
ospm install <author name> <package name> <package version number>
ospm install brennangw ospm_hello 0.4
```
This sample command will install ospm_hello v0.4 in your computer. 


### More Commands

**Uninstall**
```sh
ospm uninstall <author name> <package name> <package version number>
ospm uninstall brennangw ospm_hello 0.4
```
In each of the ospm packages, there is required-by file, which includes the dependency information
of the current package - aka, the current package depends on these extra packages, and it needs
these extra packages to run. The command above will not only remove the current package information 
from the reqiured-by file, but also allow the user to uninstall the package you do not want. 

**Clean**
```sh
ospm clean
```
This command removes dependecies for the packages that have been uninstalled. Be more specific, the
"clean" command will remove the package that has empty required-by file, which means the package is
no longer needed by its original host packages, which does not exist in the system. 

**Library**
```sh
ospm library <show>
ospm library <save> <path>
```
"ospm library show" shows library path, while "ospm library save <path>" save the library path.


**Version**
```sh
ospm version
```
This command shows the version information about the ospm installed in the system. 


**Help**
```sh
ospm help
```
This command shows command line options, the corresponding explanations and usages. 

***
If the user inputs the following in the terminal,
```sh
ospm help
```
ospm will print out potential command options for the user. 


If the user inputs commands that are not acceptable to the system, like
```sh
ospm ***????<or other commands>
```

ospm will print out:
```sh
-ospm: ***????<or other commands>: command not found
```


## Contributing
If you would like to contrbute to this ospm, 

1. Fork it!
2. Create your feature branch: 
`git checkout -b my-new-feature`
3. Commit your changes: 
`git commit -am 'Add some feature'`
4. Push to the branch: 
`git push origin my-new-feature`
5. Submit a pull request :D


## Credits

Thank for all the hardwork we have done in the TSE Team, which include Jiaxin Su, Brennan Wallace,
and Stan Pecency. Also, thank Prof. Kaiser from Columbia University provided us with precious suggestions
about how to better develop this package manager tool for OpenSCAD.


## License
MIT Open Source License. 
Attached in this GITHUB repo. 
