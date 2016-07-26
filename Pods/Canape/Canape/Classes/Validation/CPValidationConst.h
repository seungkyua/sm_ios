//
//  CPValidationConst.h
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

#ifndef CPValidationConst_h
#define CPValidationConst_h

#define VALIDATION_REX_NUMERIC @"^[1-9\\s]*$"
#define VALIDATION_REX_PHONE_NUMBER @"^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
#define VALIDATION_REX_EMAIL @"^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$"
#define VALIDATION_REX_ENGLISH @"^[a-zA-Z\\s]*$"
#define VALIDATION_REX_ENGLISH_NUMERIC @"^[1-9a-zA-Z\\s]*$"

#define VALIDATION_MESSAGE_NOT_EMPTY @"필수 입력 항목입니다"
#define VALIDATION_MESSAGE_NUMERIC @"숫자형만 입력 가능합니다"
#define VALIDATION_MESSAGE_PHONE_NUMBER @"휴대폰 번호 형식에 맞지 않습니다"
#define VALIDATION_MESSAGE_EMAIL @"이메일 형식에 맞지 않습니다"
#define VALIDATION_MESSAGE_ENGLISH @"영문만 입력가능 합니다"
#define VALIDATION_MESSAGE_ENGLISH_NUMERIC @"영문, 숫자만 입력가능 합니다"
#define VALIDATION_MESSAGE_MIN_LENGTH @"글자 이상 입력해야 합니다"
#define VALIDATION_MESSAGE_MAX_LENGTH @"글자 이상 입력할 수 없습니다"


#endif /* CPValidationConst_h */
