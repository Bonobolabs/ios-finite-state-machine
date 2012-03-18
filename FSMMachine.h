@class FSMState;

@interface FSMMachine : NSObject
@property (nonatomic, readonly, strong) NSString* state;
- (id)initWithState:(NSString*)state;
- (void)addTransition:(NSString*)event startState:(NSString*)startState endState:(NSString*)endState;
- (void)applyEvent:(NSString*)event;
- (BOOL)isInState:(NSString*)state;
@end
