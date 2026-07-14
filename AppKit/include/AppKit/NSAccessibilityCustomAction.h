#import <Foundation/Foundation.h>

typedef BOOL (^NSAccessibilityCustomActionHandler)(void);

@interface NSAccessibilityCustomAction : NSObject {
    NSString *_name;
    id _target;
    SEL _selector;
    NSAccessibilityCustomActionHandler _handler;
}

+ (instancetype) customActionWithName: (NSString *) name target: (id) target selector: (SEL) selector;
+ (instancetype) customActionWithName: (NSString *) name handler: (NSAccessibilityCustomActionHandler) handler;

- (instancetype) initWithName: (NSString *) name target: (id) target selector: (SEL) selector;
- (instancetype) initWithName: (NSString *) name handler: (NSAccessibilityCustomActionHandler) handler;

- (NSString *) name;
- (void) setName: (NSString *) name;
- target;
- (void) setTarget: target;
- (SEL) selector;
- (void) setSelector: (SEL) selector;
- (NSAccessibilityCustomActionHandler) handler;
- (void) setHandler: (NSAccessibilityCustomActionHandler) handler;
- (BOOL) perform;

@end
