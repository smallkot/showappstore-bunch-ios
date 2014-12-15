#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface ShowAppstoreBunch : UIViewController<SKStoreProductViewControllerDelegate>//NSObject
+ (id)sharedInstance;
@end