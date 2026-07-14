/*
 * This file is part of Darling.
 *
 * Copyright (C) 2024 Darling Developers
 *
 * Darling is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Darling is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Darling.  If not, see <http://www.gnu.org/licenses/>.
 */

#import <AppKit/NSScrubberItemView.h>

@implementation NSScrubberArrangedView

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [NSMethodSignature signatureWithObjCTypes: "v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"Stub called: %@ in %@", NSStringFromSelector([anInvocation selector]), [self class]);
}

@end

@implementation NSScrubberItemView

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [NSMethodSignature signatureWithObjCTypes: "v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"Stub called: %@ in %@", NSStringFromSelector([anInvocation selector]), [self class]);
}

@end

@implementation NSScrubberImageItemView

- (id) init {
    return [self initWithFrame: NSZeroRect];
}

- (id) initWithFrame: (NSRect) frame {
    if ((self = [super initWithFrame: frame])) {
        _imageView = [[NSImageView alloc] initWithFrame: [self bounds]];
        [_imageView setAutoresizingMask: NSViewWidthSizable | NSViewHeightSizable];
        [_imageView setImageFrameStyle: NSImageFrameNone];
        [_imageView setImageAlignment: NSImageAlignCenter];
        [self addSubview: _imageView];
    }
    return self;
}

- (id) initWithCoder: (NSCoder *) coder {
    if ((self = [super initWithCoder: coder])) {
        _imageView = [[NSImageView alloc] initWithFrame: [self bounds]];
        [_imageView setAutoresizingMask: NSViewWidthSizable | NSViewHeightSizable];
        [_imageView setImageFrameStyle: NSImageFrameNone];
        [_imageView setImageAlignment: NSImageAlignCenter];
        [self addSubview: _imageView];
    }
    return self;
}

- (void) dealloc {
    [_imageView release];
    [super dealloc];
}

- (void) setFrame: (NSRect) frame {
    [super setFrame: frame];
    [_imageView setFrame: [self bounds]];
}

- (NSImageView *) imageView { return _imageView; }
- (NSImage *) image { return [_imageView image]; }
- (void) setImage: (NSImage *) image { [_imageView setImage: image]; }
- (NSImageAlignment) imageAlignment { return [_imageView imageAlignment]; }
- (void) setImageAlignment: (NSImageAlignment) imageAlignment { [_imageView setImageAlignment: imageAlignment]; }

@end

@implementation NSScrubberTextItemView

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [NSMethodSignature signatureWithObjCTypes: "v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"Stub called: %@ in %@", NSStringFromSelector([anInvocation selector]), [self class]);
}

@end
