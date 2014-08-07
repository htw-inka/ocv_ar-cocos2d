# A Mobile Augmented Reality Framework based on Cocos2D and ocv_ar

*Markus Konrad <konrad@htw-berlin.de>, August 2014*

*INKA Research Group / Project MINERVA, HTW Berlin - http://inka.htw-berlin.de/inka/projekte/minerva/*

*ocv_ar-cocos2d* represents a lightweight mobile marker-based augmented reality framework for iOS based on *[Cocos2D](http://www.cocos2d-swift.org/)* for 3D visualization and user interaction, and *[ocv_ar](https://github.com/htw-inka/ocv_ar)* for marker recognition and 3D pose estimation.

## Features

* rebust marker recognition
* marker tracking with marker pose interpolation for smooth marker motions
* easy visualization via graphical marker overlays with features provided by Cocos2D such as sprites and effects
* built-in user interaction -- overlay objects in 3D scene can be selected via touch
* easy integration with Cocos2D -- no customization of Cocos2D's original source code necessary
* easy setup -- an XCode project of a showcase application is provided as basis for your application
* example project allows to see the results of the intermediate marker detection steps

## Supported (tested) OS versions and devices

* iOS 6, iOS 7
* iPad 2, iPad 3

## Usage

### How to clone this repository

Please note that all needed libraries (besides OpenCV) are included as submodules in this repository. Therefore, the following command needs to be used to clone the repo:

```
git clone --recursive git@github.com:htw-inka/ocv_ar-examples.git
```

### Compile and run the example project

This repository contains a basic example application that can be compiled using the provided XCode project file.

**Important:** It is necessary to download [OpenCV for iOS](http://sourceforge.net/projects/opencvlibrary/files/opencv-ios/) and copy *opencv2.framework* to the directory *OcvARCocos2D/Libraries/opencv2-ios/*. Otherwise, the project will not compile!

### Configuration

The ocv_ar tracker can be configured in `ARCtrl.h`. The setting is important `MARKER_REAL_SIZE_M` as it describes the side length of one physical marker in meters.

### Documentation

The provided source code is well documented so that you can easily use this project as basis for your own AR application.

### Markers

By default, [ArUco](http://sourceforge.net/projects/aruco/)-style 7x7 code markers are supported. An image with some markers can be downloaded from the [ocv_ar-examples repository](https://github.com/htw-inka/ocv_ar-examples/blob/master/assets/marker-7x7-aruco-style/board.png). You can set up ocv_ar to use custom (binary) markers via template matching.

## Dependencies

* ocv_ar
 * OpenCV (tested with v2.4.9)
* Cocos2D (submodule currently points to v3.1.1)
 * Chipmunk
 * ObjectAL

## How does it work?

A camera view is displayed beneath Cocos2D's OpenGL view that is used as graphics overlay. An OpenGL projection matrix is calculated by ocv_ar (based on the device camera properties) and is used as custom projection matrix in Cocos2D. The estimanted 3D transformations from ocv_ar for the found markers are used by Cocos2D class extensions (mainly `CCNode` and `CCSprite` extensions) for proper 3D display.

For user interaction, OpenGL picking via ray tracing has been implemented so that the correct object in the 3D scene is selected upon touch.

## Screenshots

#### Detected marker with sprite overlay

![Detected marker with sprite overlay](http://www.mkonrad.net/img/other/ocvar-cocos2d-screens01.png)

#### Display of intermediate marker detection step -- thresholding

![Display of intermediate marker detection step -- Thresholding](http://www.mkonrad.net/img/other/ocvar-cocos2d-screens02.png)

#### Display of intermediate marker detection step -- detected marker view

![Display of intermediate marker detection step -- Thresholding](http://www.mkonrad.net/img/other/ocvar-cocos2d-screens03.png)

#### Several detected markers with sprite overlay

![Several detected markers with sprite overlay](http://www.mkonrad.net/img/other/ocvar-cocos2d-screens04.png)

#### User interaction -- one selected marker

![User interaction -- one selected marker](http://www.mkonrad.net/img/other/ocvar-cocos2d-screens05.png)