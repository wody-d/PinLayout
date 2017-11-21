//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Quick
import Nimble
import PinLayout

class LayoutMethodSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        var rootView: BasicView!
        var aView: BasicView!
        
        /*
          root
           |
            - aView
        */
        
        beforeSuite {
            _pinlayoutSetUnitTest(displayScale: 2)
        }

        beforeEach {
            _pinlayoutUnitTestLastWarning = nil
            Pin.warnMissingLayoutCalls = false
            
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
            rootView.addSubview(aView)
        }
        
        afterEach {
            Pin.warnMissingLayoutCalls = false
        }
        
        //
        // layout()
        //
        describe("layout()") {
            it("test layout() method") {
                let aViewFrame = aView.frame
                aView.pin.left().right()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 400.0, height: 60.0)))
                expect(_pinlayoutUnitTestLastWarning).to(beNil())
                
                aView.frame = aViewFrame
                aView.pin.left().right().layout()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 400.0, height: 60.0)))
            }
            
            it("should warn if layout() is not called when Pin.warnMissingLayoutCalls is set to true") {
                Pin.warnMissingLayoutCalls = true
                
                aView.pin.left().right()
                expect(_pinlayoutUnitTestLastWarning).to(contain(["PinLayout commands have been issued without calling the 'layout()' method"]))
            }
        }
    }
}
