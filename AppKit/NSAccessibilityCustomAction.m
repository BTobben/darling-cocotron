#import <AppKit/NSAccessibilityCustomAction.h>
extern void *_Block_copy(const void *block);
extern void _Block_release(const void *block);

@implementation NSAccessibilityCustomAction

+ (instancetype) customActionWithName: (NSString *) name target: (id) target selector: (SEL) selector {
    return [[[[self class] alloc] initWithName: name target: target selector: selector] autorelease];
}

+ (instancetype) customActionWithName: (NSString *) name handler: (NSAccessibilityCustomActionHandler) handler {
    return [[[[self class] alloc] initWithName: name handler: handler] autorelease];
}

- (instancetype) initWithName: (NSString *) name target: (id) target selector: (SEL) selector {
    if ((self = [super init])) {
        _name = [name copy];
        _target = [target retain];
        _selector = selector;
    }
    return self;
}

- (instancetype) initWithName: (NSString *) name handler: (NSAccessibilityCustomActionHandler) handler {
    if ((self = [super init])) {
        _name = [name copy];
        _handler = handler ? (NSAccessibilityCustomActionHandler) _Block_copy(handler) : NULL;
    }
    return self;
}

- (void) dealloc {
    [_name release];
    [_target release];
    if (_handler)
        _Block_release(_handler);
    [super dealloc];
}

- (NSString *) name { return _name; }
- (void) setName: (NSString *) name {
    name = [name copy];
    [_name release];
    _name = name;
}

- target { return _target; }
- (void) setTarget: target {
    target = [target retain];
    [_target release];
    _target = target;
}

- (SEL) selector { return _selector; }
- (void) setSelector: (SEL) selector { _selector = selector; }

- (NSAccessibilityCustomActionHandler) handler { return _handler; }
- (void) setHandler: (NSAccessibilityCustomActionHandler) handler {
    if (_handler)
        _Block_release(_handler);
    _handler = handler ? (NSAccessibilityCustomActionHandler) _Block_copy(handler) : NULL;
}

- (BOOL) perform {
    if (_handler)
        return _handler(self);

    if (!_target || !_selector || ![_target respondsToSelector: _selector])
        return NO;

    NSMethodSignature *signature = [_target methodSignatureForSelector: _selector];
    if (!signature)
        return NO;

    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: signature];
    [invocation setTarget: _target];
    [invocation setSelector: _selector];
    if ([signature numberOfArguments] >= 3) {
        id action = self;
        [invocation setArgument: &action atIndex: 2];
    }

    [invocation invoke];

    const char *returnType = [signature methodReturnType];
    if (returnType && returnType[0] == @encode(BOOL)[0]) {
        BOOL result = NO;
        [invocation getReturnValue: &result];
        return result;
    }

    return YES;
}

@end
