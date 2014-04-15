//
//  Extensions.h
//  ThreeButtonProject
//
//  Created by artoorix on 11.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#ifndef ThreeButtonProject_Extensions_h
#define ThreeButtonProject_Extensions_h


#define WIDTH    self.contentSize.width
#define HEIGHT   self.contentSize.height

#define CWIDTH   contentSize.width
#define CHEIGHT  contentSize.height


#define CONTENTWIDTH   contentSize.width
#define CONTENTHEIGHT  contentSize.height

//#define IS_IPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)

#define CENTER ccp(self.contentSize.width*0.5, self.contentSize.height*0.5)

#endif
