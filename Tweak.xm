#import <substrate.h>
#import <Foundation/Foundation.h>

// ============================================
// ！！！重要：修改这里为你的服务器地址 ！！！
// ============================================
#define MY_SERVER "http://43.139.221.5:3000"
// ============================================

#define ORIGINAL_SERVER1 "http://api1.7ccccccc.com"
#define ORIGINAL_SERVER2 "http://api2.7ccccccc.com"
#define ORIGINAL_SERVER3 "http://api3.7ccccccc.com"
#define ORIGINAL_SERVER4 "http://45.205.27.82:8080"   // 新增：环境验证服务器

%hook NSURL

+ (NSURL *)URLWithString:(NSString *)URLString {
    NSString *newURLString = URLString;
    
    // 检查是否匹配任何一个原始服务器
    if ([URLString containsString:@ORIGINAL_SERVER1] ||
        [URLString containsString:@ORIGINAL_SERVER2] ||
        [URLString containsString:@ORIGINAL_SERVER3] ||
        [URLString containsString:@ORIGINAL_SERVER4]) {
        
        // 依次替换所有原始服务器地址
        newURLString = [URLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER1
                                                             withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER2
                                                               withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER3
                                                               withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER4
                                                               withString:@MY_SERVER];
        
        NSLog(@"[URLRedirect] 重定向: %@ -> %@", URLString, newURLString);
        return %orig(newURLString);
    }
    return %orig;
}

%end

%hook NSMutableURLRequest

- (void)setURL:(NSURL *)url {
    NSString *urlString = url.absoluteString;
    
    // 检查是否匹配任何一个原始服务器
    if ([urlString containsString:@ORIGINAL_SERVER1] ||
        [urlString containsString:@ORIGINAL_SERVER2] ||
        [urlString containsString:@ORIGINAL_SERVER3] ||
        [urlString containsString:@ORIGINAL_SERVER4]) {
        
        // 依次替换所有原始服务器地址
        NSString *newURLString = [urlString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER1
                                                                       withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER2
                                                               withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER3
                                                               withString:@MY_SERVER];
        newURLString = [newURLString stringByReplacingOccurrencesOfString:@ORIGINAL_SERVER4
                                                               withString:@MY_SERVER];
        
        NSURL *newURL = [NSURL URLWithString:newURLString];
        NSLog(@"[URLRedirect] 请求重定向: %@ -> %@", urlString, newURLString);
        %orig(newURL);
    } else {
        %orig;
    }
}

%end

%ctor {
    NSLog(@"[URLRedirect] 插件加载成功");
    NSLog(@"[URLRedirect] 目标服务器: " @MY_SERVER);
    NSLog(@"[URLRedirect] 重定向的域名: api1/api2/api3.7ccccccc.com 和 45.205.27.82:8080");
}
