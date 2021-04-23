//
//  APAdStatusCode.h
//  Copyright (c) 2016 KA. All rights reserved.
//
/**
 * Enumeration for error codes
 */
typedef NS_ENUM(NSInteger, APAdStatusCode) {
    APAdStatusCodeNoFill                       = 51002,    // Ad is not filled
    APAdStatusCodeDuplicateRequest             = 51003,    // Ad request duplicated against the same instance
    APAdStatusCodeMissingSlotConfig            = 51005,    // Ad slot has not been correctly configured
    APAdStatusCodeAdNotLoaded                  = 51006,    // Ad is not loaded, load ad first
    APAdStatusCodeDuplicatePresent             = 51007,    // Ad present duplicated against the same instance
    APAdStatusCodeSlotNotAvailable             = 51008,    // Ad slot is not available for your request
    APAdStatusCodeScreenOrientationIncompatible= 51009,    // Ad is unable to be presented when orientation changed since request
    APAdStatusCodeSplashContainerUnvisible     = 51011,    // ViewContainer for Splash is not visible
    APAdStatusCodeMaterialDataError            = 51012     // Ad Material download failed
};
