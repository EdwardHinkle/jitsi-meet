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

#import <Foundation/Foundation.h>

@interface JitsiMeetingOptionsBuilder : NSObject

@property (nonatomic, copy, nullable) NSURL *serverURL;
@property (nonatomic, copy, nullable) NSString *room;

@property (nonatomic, assign) BOOL audioOnly;
@property (nonatomic, assign) BOOL audioMuted;
@property (nonatomic, assign) BOOL videoMuted;

@property (nonatomic, assign) BOOL welcomePageEnabled;

@end

@interface JitsiMeetingOptions : NSObject

@property (nonatomic, copy, nullable, readonly) NSURL *serverURL;
@property (nonatomic, copy, nullable, readonly) NSString *room;

@property (nonatomic, assign, readonly) BOOL audioOnly;
@property (nonatomic, assign, readonly) BOOL audioMuted;
@property (nonatomic, assign, readonly) BOOL videoMuted;

@property (nonatomic, assign, readonly) BOOL welcomePageEnabled;

+ (instancetype)fromBuilder:(void (^)(JitsiMeetingOptionsBuilder *))initBlock;

@end
