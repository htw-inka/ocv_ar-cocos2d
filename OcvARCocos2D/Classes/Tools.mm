/**
 * OcvARCocos2D - Marker-based Augmented Reality with ocv_ar and Cocos2D.
 *
 * Common tools - implementation file.
 *
 * Author: Markus Konrad <konrad@htw-berlin.de>, August 2014.
 * INKA Research Group, HTW Berlin - http://inka.htw-berlin.de/
 *
 * See LICENSE for license.
 */

#import "Tools.h"

#import <sys/utsname.h>

@implementation Tools

+ (void)convertYUVSampleBuffer:(CMSampleBufferRef)buf toGrayscaleMat:(cv::Mat &)mat {
    CVImageBufferRef imgBuf = CMSampleBufferGetImageBuffer(buf);
    
    // lock the buffer
    CVPixelBufferLockBaseAddress(imgBuf, 0);
    
    // get the address to the image data
//    void *imgBufAddr = CVPixelBufferGetBaseAddress(imgBuf);   // this is wrong! see http://stackoverflow.com/a/4109153
    void *imgBufAddr = CVPixelBufferGetBaseAddressOfPlane(imgBuf, 0);
    
    // get image properties
    int w = (int)CVPixelBufferGetWidth(imgBuf);
    int h = (int)CVPixelBufferGetHeight(imgBuf);
    
    // create the cv mat
    mat.create(h, w, CV_8UC1);              // 8 bit unsigned chars for grayscale data
    memcpy(mat.data, imgBufAddr, w * h);    // the first plane contains the grayscale data
                                            // therefore we use <imgBufAddr> as source
    
    // unlock again
    CVPixelBufferUnlockBaseAddress(imgBuf, 0);
}

+ (UIImage *)imageFromCvMat:(const cv::Mat *)mat {
    // code from Patrick O'Keefe (http://www.patokeefe.com/archives/721)
    NSData *data = [NSData dataWithBytes:mat->data length:mat->elemSize() * mat->total()];
    
    CGColorSpaceRef colorSpace;
    
    if (mat->elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(mat->cols,                                 //width
                                        mat->rows,                                 //height
                                        8,                                          //bits per component
                                        8 * mat->elemSize(),                       //bits per pixel
                                        mat->step.p[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}

+ (cv::Mat *)cvMatFromImage:(const UIImage *)img gray:(BOOL)gray {
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(img.CGImage);
    
    const int w = [img size].width;
    const int h = [img size].height;
    
    // create cv::Mat
    cv::Mat *mat = new cv::Mat(h, w, CV_8UC4);
    
    // create context
    CGContextRef contextRef = CGBitmapContextCreate(mat->ptr(),
                                                    w, h,
                                                    8,
                                                    mat->step[0],
                                                    colorSpace,
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault);
    
    if (!contextRef) {
        delete mat;
        
        return NULL;
    }
    
    // draw the image in the context
    CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), img.CGImage);
    
    CGContextRelease(contextRef);
    //    CGColorSpaceRelease(colorSpace);  // "colorSpace" is not owned, only referenced
    
    // convert to grayscale data if necessary
    if (gray) {
        cv::Mat *grayMat = new cv::Mat(h, w, CV_8UC1);
        cv::cvtColor(*mat, *grayMat, CV_RGBA2GRAY);
        delete mat;
        
        return grayMat;
    }
    
    return mat;
}

+ (NSString *)deviceModelID {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineInfo = [[NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding] lowercaseString];
    
    return machineInfo;
}

+ (NSString *)deviceModelShort {
    NSString *m = [Tools deviceModelID];
    
    NSArray *splitModel = [m componentsSeparatedByString:@","];
    
    if ([splitModel count] < 2) {
        return m; // default
    }
    
    NSString *modelStr = @"ipad";
    NSString *majNumStr = [[splitModel objectAtIndex:0] substringFromIndex:4];
    NSString *minNumStr = [splitModel objectAtIndex:1];
    
    int majNum = atoi([majNumStr cStringUsingEncoding:NSASCIIStringEncoding]);
    int minNum = atoi([minNumStr cStringUsingEncoding:NSASCIIStringEncoding]);
    
    if (majNum == 2) {
        return [modelStr stringByAppendingString:@"2"];
    } else if (majNum == 3 && minNum < 4) {
        return [modelStr stringByAppendingString:@"3"];
    } else if (majNum == 3 && minNum >= 4) {
        return [modelStr stringByAppendingString:@"4"];
    } else if (majNum == 4 && minNum < 4) {
        return [modelStr stringByAppendingString:@"-air"];
    } else {
        return nil;
    }
}


+ (void)printGLKMat4x4:(const GLKMatrix4 *)mat {
    for (int y = 0; y < 4; ++y) {
        for (int x = 0; x < 4; ++x) {
            printf("%f ", mat->m[y * 4 + x]);
        }
        
        printf("\n");
    }
}

@end
