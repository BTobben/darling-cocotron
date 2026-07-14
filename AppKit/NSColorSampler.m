#import <AppKit/NSColorSampler.h>
#import <dispatch/dispatch.h>

@implementation NSColorSampler

- (void) showSamplerWithSelectionHandler: (void (^)(NSColor *selectedColor)) selectionHandler
{
    if (selectionHandler == nil)
        return;

    void (^handler)(NSColor *) = [selectionHandler copy];
    NSColorSampler *sampler = [self retain];

    dispatch_async(dispatch_get_main_queue(), ^{
        handler(nil);
        [handler release];
        [sampler release];
    });
}

@end
