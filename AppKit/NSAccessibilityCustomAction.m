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
        /* AppKit documents target as weak; under MRC this is assign-only. */
        _target = target;
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
    /* AppKit documents target as weak; under MRC this is assign-only. */
    _target = target;
}

- (SEL) selector { return _selector; }
- (void) setSelector: (SEL) selector { _selector = selector; }

- (NSAccessibilityCustomActionHandler) handler { return _handler; }
- (void) setHandler: (NSAccessibilityCustomActionHandler) handler {
    NSAccessibilityCustomActionHandler newHandler = handler ?
            (NSAccessibilityCustomActionHandler) _Block_copy(handler) : NULL;
    if (_handler)
        _Block_release(_handler);
    _handler = newHandler;
}

- (BOOL) perform {
    if (_handler)
        return _handler();

    if (!_target || !_selector || ![_target respondsToSelector: _selector])
        return NO;

    NSMethodSignature *signature = [_target methodSignatureForSelector: _selector];
    if (!signature)
        return NO;

    NSUInteger arguments = [signature numberOfArguments];
    if (arguments != 2 && arguments != 3)
        return NO;

    const char *returnType = [signature methodReturnType];
    while (*returnType == 'r' || *returnType == 'n' || *returnType == 'N' ||
           *returnType == 'o' || *returnType == 'O' || *returnType == 'R' ||
           *returnType == 'V')
        returnType++;

    if (returnType[0] != @encode(BOOL)[0] && returnType[0] != 'B' &&
            returnType[0] != 'c' && returnType[0] != 'C')
        return NO;

    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: signature];
    [invocation setTarget: _target];
    [invocation setSelector: _selector];
    if (arguments == 3) {
        id action = self;
        [invocation setArgument: &action atIndex: 2];
    }

    [invocation invoke];

    BOOL result = NO;
    [invocation getReturnValue: &result];
    return result;
}

@end
