#import <substrate.h>
#import <Foundation/Foundation.h>

// ============================================
// URL 重定向插件 - 将插件服务器请求指向你自己的服务器
// ============================================

// 你的服务器地址（修改这里！）
#define MY_SERVER "http://43.139.221.5:3000"
#define ORIGINAL_SERVER1 "http://api1.7ccccccc.com"
#define ORIGINAL_SERVER2 "http://api2.7ccccccc.com"
#define ORIGINAL_SERVER3 "http://api3.7ccccccc.com"

%hook NSURL

+ (NSURL *)URLWithString:(NSString *)URLString {
    NSString *newURLString = URLString;
    
    if ([URLString containsString:@ORIGINAL_SERVER1] ||
        [URLString containsString:@ORIGINAL_SERVER2] ||
        [URLString containsString:@ORIGINAL_SERVER3]) {
        
        newURLString = [URLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER1
                                                             withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER2
                                                               withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER3
                                                               withString:@MY_SERVER];
        NSLog(@"[URLRedirect] %@ -> %@", URLString, newURLString);
        return %orig(newURLString);
    }
    return %orig;
}

%end

%hook NSMutableURLRequest

- (void)setURL:(NSURL *)url {
    NSString *urlString = url.absoluteString;
    
    if ([urlString containsString:@ORIGINAL_SERVER1] ||
        [urlString containsString:@ORIGINAL_SERVER2] ||
        [urlString containsString:@ORIGINAL_SERVER3]) {
        
        NSString *newURLString = [urlString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER1
                                                                       withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER2
                                                               withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER3
                                                               withString:@MY_SERVER];
        NSURL *newURL = [NSURL URLWithString:newURLString];
        NSLog(@"[URLRedirect] Request: %@ -> %@", urlString, newURLString);
        %orig(newURL);
    } else {
        %orig;
    }
}

%end

%ctor {
    NSLog(@"[URLRedirect] 插件加载成功");
    NSLog(@"[URLRedirect] 目标服务器: " @MY_SERVER);
}
