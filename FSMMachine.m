#import "FSMMachine.h"

@interface FSMMachine()
@property (nonatomic, readwrite, strong) const NSString* state;
@property (nonatomic, strong) NSMutableDictionary* transitions;
@end

@implementation FSMMachine
@synthesize state = _state;
@synthesize transitions;

- (id)initWithState:(const NSString*)state {
    self = [super init];
    
    if (self) {
        self.state = state;
        self.transitions = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)addTransition:(const NSString*)event startState:(const NSString*)startState endState:(const NSString*)endState {    
    NSMutableDictionary* startEndMap = nil;
    
    startEndMap = [self.transitions objectForKey:event];
    
    if (!startEndMap) {
        startEndMap = [NSMutableDictionary dictionary];
        [self.transitions setObject:startEndMap forKey:event];
    }
    
    [startEndMap setObject:endState forKey:startState];
}

- (void)applyEvent:(const NSString*)event { 
    BOOL valid = NO;
    
    NSDictionary* startEndMap = [self.transitions objectForKey:event];
    if (startEndMap) {
        NSString* endState = [startEndMap objectForKey:self.state];
        if (endState) {
            self.state = endState;
            valid = YES;
        }
    }
    
    if (!valid) {
        [NSException raise:@"Invalid Event" format:@"Tried to appy event %@ while in state %@", event, self.state];
    }
}
        
- (BOOL)isInState:(const NSString *)state {
    return self.state == state;
}

@end
