#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FLTFirebaseRemoteConfigPlugin.h"
#import "FLTFirebaseRemoteConfigUtils.h"

FOUNDATION_EXPORT double firebase_remote_configVersionNumber;
FOUNDATION_EXPORT const unsigned char firebase_remote_configVersionString[];

