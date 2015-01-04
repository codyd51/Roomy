#import <CoreGraphics/CoreGraphics.h>

@interface SBLockScreenView : UIView {
	UIView* _slideToUnlockView;
}
@property UIView* notificationView;
@end
@interface _UIGlintyStringView : UILabel
@end

//SBLockScreenNotificationTableView
BOOL hasSetLayoutOnce;
CGRect referenceFrame;

%hook SBFLockScreenDateView

-(CGRect)frame {
	CGRect r = %orig;

	return CGRectMake(r.origin.x, 20, r.size.width, r.size.height);
}
-(void)setFrame:(CGRect)frame {
	CGRect r = frame;

	NSLog(@"[Roomy] Clock - Original frame is %@", NSStringFromCGRect(frame));

	%orig(CGRectMake(r.origin.x, 20, r.size.width, r.size.height));
}
%end

%hook _UIGlintyStringView

-(CGRect)frame {
	CGRect r = %orig;
	NSLog(@"[Roomy] STU - Original frame is %@", NSStringFromCGRect(r));

	if (![self.text isEqualToString:@"slide to power off"]) { 
		float y = [[UIScreen mainScreen] bounds].size.height/30;
		CGRect adjustedFrame = CGRectMake(r.origin.x, r.origin.y+y, r.size.width, r.size.height);
		return adjustedFrame;
	}
	return r;
}
-(void)setFrame:(CGRect)frame {
	NSLog(@"[Roomy] STU - Original frame is %@", NSStringFromCGRect(frame));
	CGRect r = frame;

	if (![self.text isEqualToString:@"slide to power off"]) { 
		float y = [[UIScreen mainScreen] bounds].size.height/30;
		CGRect adjustedFrame = CGRectMake(r.origin.x, r.origin.y+y, r.size.width, r.size.height);
		%orig(adjustedFrame);
	}
	else %orig(r);
}

%end

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