import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        // Configure the web view for better YouTube experience
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Handle navigation start if needed
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Inject CSS to hide YouTube's tab bar and other elements
            let cssString = """
                /* Hide YouTube's main header/navigation */
                #masthead-container,
                ytd-masthead,
                #header,
                .ytd-masthead,
                #guide-button,
                #logo,
                #search,
                #end,
                ytd-searchbox,
                
                /* Hide bottom tab bar on mobile */
                .mobile-topbar-header,
                .mobile-topbar-header-content,
                ytm-mobile-topbar-renderer,
                ytm-pivot-bar-renderer,
                .pivot-bar-renderer,
                .mobile-topbar-logo,
                
                /* Hide desktop sidebar */
                #guide,
                #guide-content,
                ytd-guide-renderer,
                
                /* Hide any floating elements */
                .ytp-chrome-top,
                .ytp-show-cards-title,
                
                /* Additional mobile elements */
                ytm-header,
                .header,
                .topbar,
                
                /* Hide YouTube shorts shelf if present */
                ytd-rich-shelf-renderer[is-shorts],
                
                /* Hide any overlay elements */
                .ytp-pause-overlay,
                .ytp-scroll-min
                {
                    display: none !important;
                    visibility: hidden !important;
                    height: 0 !important;
                    min-height: 0 !important;
                    max-height: 0 !important;
                    overflow: hidden !important;
                }
                
                /* Adjust main content to fill the space */
                #page-manager,
                ytd-page-manager,
                #primary,
                #contents,
                ytd-browse,
                ytd-two-column-browse-results-renderer {
                    margin-top: 0 !important;
                    padding-top: 0 !important;
                }
                
                /* Make content full width */
                ytd-page-manager #primary {
                    margin-left: 0 !important;
                }
                
                /* Hide any remaining top spacing */
                body {
                    padding-top: 0 !important;
                    margin-top: 0 !important;
                }
                
                /* Ensure video player is responsive */
                .html5-video-player {
                    width: 100% !important;
                }
            """
            
            let jsString = """
                var style = document.createElement('style');
                style.innerHTML = `\(cssString)`;
                document.head.appendChild(style);
                
                // Also try to remove elements via JavaScript as backup
                setTimeout(function() {
                    var elementsToHide = [
                        '#masthead-container',
                        'ytd-masthead',
                        '.mobile-topbar-header',
                        'ytm-mobile-topbar-renderer',
                        'ytm-pivot-bar-renderer',
                        '#guide',
                        'ytm-header'
                    ];
                    
                    elementsToHide.forEach(function(selector) {
                        var elements = document.querySelectorAll(selector);
                        elements.forEach(function(element) {
                            element.style.display = 'none';
                            element.style.visibility = 'hidden';
                            element.style.height = '0';
                        });
                    });
                }, 1000);
            """
            
            webView.evaluateJavaScript(jsString) { result, error in
                if let error = error {
                    print("JavaScript injection failed: \(error.localizedDescription)")
                }
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("WebView navigation failed: \(error.localizedDescription)")
        }
    }
} 