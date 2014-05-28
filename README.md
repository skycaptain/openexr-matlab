# OpenEXR for Matlab

### Note
This is a modified mirror repository for the OpenEXR-Bindings from *HDRITools - High Dynamic Range Image Tools*. The original code is either incompatible or hard to compile with the latest versions of OpenEXR and mex, so we modified and cleaned-up their code to be hassle-free compatible with the latest versions of MATLAB, Xcode and the OpenEXR-Library.

The original code can be obtained at [https://bitbucket.org/edgarv/hdritools/](https://bitbucket.org/edgarv/hdritools/). The original copyright remains to Jinwei Gu and Edgar Velazquez-Armendariz.

### What is it?
OpenEXR is a popular high dynamic range image fileformat mainly used by the film industry. This repository provides an interface for reading and writing OpenEXR files within MATLAB.

### Install
Install the latest version of the OpenEXR-Library, e.g. via [Homebrew](http://brew.sh/):

	$ brew install openexr

Now just run `make.m` inside of MATLAB to comile the bindings. If you install the OpenEXR-Library without Homebrew you may also change the pathname inside of `make.m` to the path you've installed the OpenEXR-Library.

You may also need to update your `mexopts.sh`. An updated version of `mexopts.sh` is included within the files, just diff them, or just copy the file to `~/.matlab`.

Now you can use `exrread`, `exrreadchannels`, `exrwrite`, `exrwritechannels` and `exrinfo` just like any other MATLAB-Function.

### Usage
##### exrread
	>> image = exrread('my_image.exr');
	>> size(image)
	ans =

	        1080        1920           3

	>> max(image(:))
	ans =
	
	    2.9297
	
	>> min(a(:))
	ans =
	
	    0.3069

##### exrwrite
	>> a = 100 * rand(300,300,3);
	>> size(a)
	ans =
	
	   300   300     3
	
	>> exrwrite(a, 'a.exr');

### Ceveats
The code was only tested with OSx 10.9.3 Mavericks, MATLAB 2014a 8.3.0, Xcode Version 5.1.1 and OpenEXR 2.1.0.

### Authors
Jinwei Gu <jwgu AT cs DOT cornell DOT edu>  
Edgar Velazquez-Armendariz <eva5 AT cs DOT cornell DOT edu>  
Manuel Leonhardt <leom AT hs-furtwangen DOT de>  
