CXAdjustBlockView
=================

A self-management container(UIScrollView) of views(UIView) for iOS (iPhone/iPad) that make all the views linked on one direction relationship with animation scaling.

---
**How to use**

* New a container(CXBlockScrollView).
```Objective-C 
containerView = [[CXBlockScrollView alloc] initWithFrame:<#(CGRect)#>];
```
* Use addBlockview:withSpacing: to add views to container.
 @Notice
 The x-axis value will assign as horizontal offset, and y-axis value must be zeor. You could assign vertical offset with spacing.
 Recommend to  use when adding each view as a blockview object in container. 
```Objective-C 
UIView *someView = [[UIView alloc] initWithFrame:<#(CGRect)#>];
[containerView addBlockview:someView withSpacing:<#(NSUInteger)#>];
```

**Coming soon**:
* Remove blockView
* Reuse
* Animation tuning

**Supports**:
* iOS 4 or later.
* Xcode 4.2 (CXAdjustBlockView uses ARC)
* Frameworks: Foundation, UIKit, CoreGraphics and QuartzCore.

---
##Contact
* Facebook - https://www.facebook.com/weize.xu
* Twitter - https://twitter.com/taterctl
* E-mail - taterctl@gmail.com

---
##License

Copyright (c) 2013 Chris Xu, http://greenchiu.github.com/ Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

