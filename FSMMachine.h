@class FSMState;

@interface FSMMachine : NSObject
- (id)initWithState:(NSString*)state;
- (void)addTransition:(NSString*)event startState:(NSString*)startState endState:(NSString*)endState;
- (void)applyEvent:(NSString*)event;
- (BOOL)isInState:(NSString*)state;
@end
