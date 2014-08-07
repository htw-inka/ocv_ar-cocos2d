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

## Supported (tested) OS versions and devices

* iOS 6
* iOS 7

* iPad 2 
* iPad 3

## Usage

### Markers

By default, [ArUco](http://sourceforge.net/projects/aruco/)-style 7x7 code markers are supported. An image with some markers can be downloaded from the [ocv_ar-examples repository](https://github.com/htw-inka/ocv_ar-examples/blob/master/assets/marker-7x7-aruco-style/board.png). You can set up ocv_ar to use custom (binary) markers via template matching.

### Example project and documentation

This repository contains a basic example application that can be compiled using the provided XCode project file. The provided source code is well documented so that you can easily use this project as basis for your own AR application.

## Dependencies

* ocv_ar
 * OpenCV
* Cocos2D
 * Chipmunk
 * ObjectAL

## How does it work?

A camera view is displayed beneath Cocos2D's OpenGL view that is used as graphics overlay. An OpenGL projection matri is calculated by ocv_ar (based on the device camera properties) and is used as custom projection matrix in Cocos2D. The estimanted 3D transformations from ocv_ar for the found markers are used by Cocos2D class extensions (mainly `CCNode` and `CCSprite` extension) for proper 3D display.

For user interaction, OpenGL picking via ray tracing has been implemented so that the correct object in the 3D scene is selected upon touch.

## Screenshots