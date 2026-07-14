#import <Foundation/Foundation.h>
#import <AppKit/NSFontDescriptor.h>

typedef NSInteger NSImageSymbolScale;

enum {
    NSImageSymbolScaleSmall = 1,
    NSImageSymbolScaleMedium = 2,
    NSImageSymbolScaleLarge = 3,
};

@interface NSImageSymbolConfiguration : NSObject <NSCopying> {
    CGFloat _pointSize;
    NSFontWeight _weight;
    NSImageSymbolScale _scale;
}

+ (instancetype) configurationWithPointSize: (CGFloat) pointSize weight: (NSFontWeight) weight scale: (NSImageSymbolScale) scale;
- (CGFloat) pointSize;
- (NSFontWeight) weight;
- (NSImageSymbolScale) scale;

@end
