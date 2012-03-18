#import "FSMMachine.h"

@interface FSMMachine()
@property (nonatomic, strong) NSString* state;
@property (nonatomic, strong) NSMutableDictionary* transitions;
@end

@implementation FSMMachine
@synthesize state = _state;
@synthesize transitions;

- (id)initWithState:(NSString*)state {
    self = [super init];
    
    if (self) {
        self.state = state;
        self.transitions = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)addTransition:(NSString*)event startState:(NSString*)startState endState:(NSString*)endState {    
    NSMutableDictionary* startEndMap = nil;
    
    startEndMap = [self.transitions objectForKey:event];
    
    if (!startEndMap) {
        startEndMap = [NSMutableDictionary dictionary];
        [self.transitions setObject:startEndMap forKey:event];
    }
    
    [startEndMap setObject:endState forKey:startState];
}

- (void)applyEvent:(NSString*)event { 
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
        
- (BOOL)isInState:(NSString *)state {
    return [state isEqualToString:self.state];
}

@end
