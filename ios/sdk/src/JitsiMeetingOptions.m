/*
 * Copyright @ 2019-present 8x8, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <React/RCTUtils.h>

#import "JitsiMeetingOptions+Private.h"

@implementation JitsiMeetingOptionsBuilder

- (instancetype)init {
    if (self = [super init]) {
        _serverURL = nil;
        _room = nil;
        _audioOnly = [NSNull null];
        _audioMuted = NO;
        _videoMuted = NO;
        _welcomePageEnabled = NO;
    }
    
    return self;
}

@end

@implementation JitsiMeetingOptions

#pragma mark - Internal initializers

- (instancetype)init {
    return [self initWithBuilder:[[JitsiMeetingOptionsBuilder alloc] init]];
}

- (instancetype)initWithBuilder:(JitsiMeetingOptionsBuilder *)builder {
    if (self = [super init]) {
        _serverURL = builder.serverURL;
        _room = builder.room;
        _audioOnly = builder.audioOnly;
        _audioMuted = builder.audioMuted;
        _videoMuted = builder.videoMuted;
        _welcomePageEnabled = builder.welcomePageEnabled;
    }
    
    return self;
}

#pragma mark - API

+ (instancetype)fromBuilder:(void (^)(JitsiMeetingOptionsBuilder *))initBlock {
    JitsiMeetingOptionsBuilder *builder = [[JitsiMeetingOptionsBuilder alloc] init];
    initBlock(builder);
    return [[JitsiMeetingOptions alloc] initWithBuilder:builder];
}

#pragma mark - Private API

- (NSMutableDictionary *)asProps {
    NSMutableDictionary *props = [[NSMutableDictionary alloc] init];

    if (self.serverURL) {
        // TODO: rename to serverURL
        props[@"defaultURL"] = [self.serverURL absoluteString];
    }

    // TODO: use some sort of flags
    props[@"welcomePageEnabled"] = @(self.welcomePageEnabled);
    
    NSString *url = nil;
    if (self.room != nil) {
        url = [[NSURL URLWithString:self.room relativeToURL:self.serverURL] absoluteString];
    }
    
    props[@"url"]
        = @{
            @"url" : RCTNullIfNil(url),
            @"config" : @{
                    @"startAudioOnly": @(self.audioOnly),
                    @"startWithAudioMuted": @(self.audioMuted),
                    @"startWithVideoMuted": @(self.videoMuted)
                         }
            };

    return props;
}

@end
