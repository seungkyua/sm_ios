//
//  CPHybridConst.h
//  CanapeProject
//
//  Canape Software License
//  Copyright (c) 2016 BliexSoft, Inc.
//
//  Permission to use, copy, modify, and distribute this software
//  and its documentation for any purpose, without fee, and without
//  a written agreement is hereby granted, provided that the above
//  copyright notice and this and the following paragraphs appear
//  in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#ifndef CPHybridConst_h
#define CPHybridConst_h

#pragma Protocol

/**
 * @brief 플러그인
 */
static NSString *PROTOCOL_PULUGIN = @"plugins://";

/**
 * @brief 메소드
 */
static NSString *PROTOCOL_METHOD = @"method";

/**
 * @brief 서비스 태스크명
 */
static NSString *PROTOCOL_NAME = @"name";

/**
 * @brief 인자
 */
static NSString *PROTOCOL_ARGS = @"args";

/**
 * @brief 콜백명
 */
static NSString *PROTOCOL_CALLBACK = @"callback";


#pragma JS

/**
 * @brief 자바스크립트 접두
 */
static NSString *JS_PREFIX = @"javascript:";

/**
 * @brief 성공 콜백 접두
 */
static NSString *JS_SUCCESS_PREFIX = @"javascript:Canape.plugin.receiveSuccess('";

/**
 * @brief 성공 콜백 접미
 */
static NSString *JS_SUCCESS_SUFFIX = @"')";

/**
 * @brief 에러 콜백 접두
 */
static NSString *JS_ERROR_PREFIX = @"javascript:Canape.plugin.receiveError('";

/**
 * @brief 에러 콜백 접미
 */
static NSString *JS_ERROR_SUFFIX = @"')";

static NSString *JS_ACTIVATED = @"javascript:Canape.device.onActivated()";
static NSString *JS_DEACTIVATED = @"javascript:Canape.device.onDeactivated()";
static NSString *JS_BACK_PRESSED = @"javascript:Canape.device.onBackPressed()";
static NSString *JS_DEVICE_READY = @"javascript:Canape.device.onDeviceReady()";

#endif /* CPHybridConst_h */
