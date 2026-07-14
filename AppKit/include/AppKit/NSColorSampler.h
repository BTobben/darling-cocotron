#import <Foundation/Foundation.h>
#import <AppKit/NSColor.h>

@interface NSColorSampler : NSObject

- (void) showSamplerWithSelectionHandler: (void (^)(NSColor *selectedColor)) selectionHandler;

@end
