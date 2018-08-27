//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SFormatterKit.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      08/27/2018: Created by Cyrex on 08/27/2018
//

#import <UIKit/UIKit.h>

//! Project version number for SFormatterKit.
FOUNDATION_EXPORT double SFormatterKitVersionNumber;

//! Project version string for SFormatterKit.
FOUNDATION_EXPORT const unsigned char SFormatterKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SFormatterKit/PublicHeader.h>
#if __has_include(<SFormatterKit/SFormatterKit.h>)
    #import <SFormatterKit/UITextField+SFormatterKit.h>
    #import <SFormatterKit/SNormalFormatter.h>
    #import <SFormatterKit/SCreditCardFormatter.h>
    #import <SFormatterKit/SDateFormatter.h>
#else
    #import "UITextField+SFormatterKit.h"
    #import "SNormalFormatter.h"
    #import "SCreditCardFormatter.h"
    #import "SDateFormatter.h"
#endif
