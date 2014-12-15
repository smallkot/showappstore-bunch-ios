#import "ShowAppstoreBunch.h"

#import <UIKit/UIKit.h>
#import "ProcessorEngine.h"

@implementation ShowAppstoreBunch {
}

+ (id)sharedInstance {
    static ShowAppstoreBunch *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self alloc];
    });
    return sharedInstance;
}

+ (void)initialize {
    [super initialize];
    [self initGlue];
}

+ (void)registerProcessorForKey:(NSString *)key withBlock:(void (^)(NSDictionary *parameters, NSMutableDictionary *retParameters))callHandler {
    [[ProcessorEngine sharedInstance] registerProcessorForBunch:@"ShowAppstoreBunch" andKey:key withBlock:callHandler];
}

+ (void)initGlue {
    
    [self registerProcessorForKey:@"showAppstore" withBlock:^(NSDictionary *parameters, NSMutableDictionary *retParameters) {
        NSString *text = parameters[@"text"];
        [[ShowAppstoreBunch sharedInstance] showAppstore:text];
    }];
}

- (void)showAppstore:(NSString *)text {
    
    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    
    // Configure View Controller
    [storeProductViewController setDelegate:self];
    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : text} completionBlock:^(BOOL result, NSError *error) {
        if (error) {
            NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
            
        }
    }];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:storeProductViewController animated:YES completion:nil];
    
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    if (viewController)
    {
        [[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


@end