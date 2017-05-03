# OpenSCADpm

Package Managers have become powerful tools that assist software engineers during their development process. 
We found that there are no package managers for OpenSCAD Language, a language used for computer assisted 
designing. Thus, we intend to create a package manager for OpenSCAD, akin to Node Package Manager (NPM) or 
Ruby Gems, which will allow developers to more easily share and install modules. Furthermore, it will allow 
users to manage dependencies. 

To this end we want to create a command line tool and a website. The command line tool will be used for the 
installation and managing of modules by allowing users to use terminal commands. The website will allow users 
to upload packages. It will also serve as a way for packages to be browsed and explained with a high level 
description (this seems to be the norm for package managers).

## Synopsis
The Installation section is just enough infor to get you up and running. 
Much more informaiton available in the Usage section and the documentation file we have in this repo.

## OpenSCADpm Installation
** This version of OpenSCADpm is only for Macs **

1. Install the lastest version of OpenSCADpm by visiting the website below and click the "DOWNLOAD OPENSCADPM" link.

```sh
https://skp2140.github.io/openSCADpm/index.html
```

2. Unzip the zip.file downloaded from the given website link above.

3. Change the name of the opened folder from "openSCADpm-master" to "ospm."

4. Open terminal, go to **the folder that contains "ospm" folder **, and enter the following command
```sh
mv ospm /usr/local/lib/
```
This command will move the ospm folder to the location /usr/local/lib/ folder, which allows the users 
to used ospm from anywhere in the system without restriction. 

## OpenSCADpm Package Installation and Usage

There are two approaches to use ospm for package installing, uninstalling and other options: User 
Script Approach and Package Name Approach. 

### User Script Approach
You can create a user script (txt file recommended) that contains the dependencies of packages for 
OpenSCAD packages. 

```sh
ospm install list myList.txt
```

```sh
cat myList.txt
```


```sh
brennangw ospm_hello 0.4
brennangw echo 0.1
```


User script example - myList.txt: 
```sh
User script sample content
```

### Package Name Approach

```sh
ospm install brennangw ospm_hello 0.4
```


### More Commands

uninstall
```sh
ospm install brennangw ospm_hello 0.4
```

library
```sh
ospm install brennangw ospm_hello 0.4
```

version
```sh
ospm install brennangw ospm_hello 0.4
```

help
```sh
ospm install brennangw ospm_hello 0.4
```




## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

TODO: Write history

## Credits

TODO: Write credits

## License
MIT Open Source License. 
Attached 
