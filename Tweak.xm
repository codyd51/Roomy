//SBLockScreenNotificationTableView

%hook SBFLockScreenDateView

-(CGRect)frame {
	CGRect r = %orig;
	NSLog(@"[Roomy] Original frame is %@", NSStringFromCGRect(r));
	CGRect adjustedFrame = CGRectMake(r.origin.x, r.origin.y/3, r.size.width, r.size.height);

	return adjustedFrame;
}
-(void)setFrame:(CGRect)frame {
	CGRect r = frame;
	NSLog(@"[Roomy] Original frame is %@", NSStringFromCGRect(frame));
	CGRect adjustedFrame = CGRectMake(r.origin.x, r.origin.y/3, r.size.width, r.size.height);
	%orig(adjustedFrame);
}

%end

%hook _UIGlintyStringView

-(CGRect)frame {
	CGRect r = %orig;
	NSLog(@"[Roomy] STU - Original frame is %@", NSStringFromCGRect(r));

	float y = [[UIScreen mainScreen] bounds].size.height/30;
	CGRect adjustedFrame = CGRectMake(r.origin.x, r.origin.y+y, r.size.width, r.size.height);
	return adjustedFrame;
}
-(void)setFrame:(CGRect)frame {
	NSLog(@"[Roomy] STU - Original frame is %@", NSStringFromCGRect(frame));
	CGRect r = frame;

	float y = [[UIScreen mainScreen] bounds].size.height/30;
	CGRect adjustedFrame = CGRectMake(r.origin.x, r.origin.y+y, r.size.width, r.size.height);
	%orig(adjustedFrame);
}

%end

@interface SBLockScreenView : UIView 
@property UIView* notificationView;
@end

%hook SBLockScreenView 

-(void)layoutSubviews {
	%orig;

	UIView* noteView = self.notificationView;
	CGRect r = noteView.frame;
	NSLog(@"[Roomy] NotificationView - Original frame is %@", NSStringFromCGRect(r));

	float y = [[UIScreen mainScreen] bounds].size.height/12;
	CGRect adjustedFrame = CGRectMake(r.origin.x, r.origin.y-y, r.size.width, r.size.height+(y+(y/1.5)));

	self.notificationView.frame = adjustedFrame;
}

%end