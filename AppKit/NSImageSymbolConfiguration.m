#import <AppKit/NSImageSymbolConfiguration.h>

@implementation NSImageSymbolConfiguration

+ (instancetype) configurationWithPointSize: (CGFloat) pointSize weight: (NSFontWeight) weight scale: (NSImageSymbolScale) scale {
    NSImageSymbolConfiguration *configuration = [[[self class] alloc] init];
    configuration->_pointSize = pointSize;
    configuration->_weight = weight;
    configuration->_scale = scale;
    return [configuration autorelease];
}

- (id) copyWithZone: (NSZone *) zone {
    NSImageSymbolConfiguration *copy = [[[self class] allocWithZone: zone] init];
    copy->_pointSize = _pointSize;
    copy->_weight = _weight;
    copy->_scale = _scale;
    return copy;
}

- (CGFloat) pointSize { return _pointSize; }
- (NSFontWeight) weight { return _weight; }
- (NSImageSymbolScale) scale { return _scale; }

@end
