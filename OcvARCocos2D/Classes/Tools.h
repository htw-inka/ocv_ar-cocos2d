/**
 * OcvARCocos2D - Marker-based Augmented Reality with ocv_ar and Cocos2D.
 *
 * Common tools - header file.
 *
 * Author: Markus Konrad <konrad@htw-berlin.de>, August 2014.
 * INKA Research Group, HTW Berlin - http://inka.htw-berlin.de/
 *
 * See LICENSE for license.
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>

@interface Tools : NSObject

/**
 * Convert a sample buffer <buf> from the camera (YUV 4:2:0 [NV12] pixel format) to an
 * OpenCV <mat> that will contain only the luminance (grayscale) data
 * See http://www.fourcc.org/yuv.php#NV12 and https://wiki.videolan.org/YUV/#NV12.2FNV21
 * for details about the pixel format
 */
+ (void)convertYUVSampleBuffer:(CMSampleBufferRef)buf toGrayscaleMat:(cv::Mat &)mat;

/**
 * Convert cv::mat image data to UIImage
 * code from Patrick O'Keefe (http://www.patokeefe.com/archives/721)
 */
+ (UIImage *)imageFromCvMat:(const cv::Mat *)mat;

// get a cvMat image from an UIImage
+ (cv::Mat *)cvMatFromImage:(const UIImage *)img gray:(BOOL)gray;

/**
 * Get the full device name id such as "ipad2,1".
 */
+ (NSString *)deviceModelID;

/**
 * Get the short device name: ipad, ipad2, ipad3, ipad4 or ipad-air.
 * Codes taken from https://theiphonewiki.com/wiki/IPad
 * *Note:* Only works with ipad models!
 */
+ (NSString *)deviceModelShort;

/**
 * Print a GLKMatrix4 <mat> to the console.
 */
+ (void)printGLKMat4x4:(const GLKMatrix4 *)mat;

@end
