platform :ios, '10.0'

def product_pods
	pod 'SwiftyNotifications', :path => '.'
end

workspace 'SwiftyNotifications.xcworkspace'
project 'SwiftyNotifications.xcodeproj'

target 'Sample' do
	project 'Sample/Sample.xcodeproj'
	use_frameworks!
    inherit! :search_paths
    product_pods
end
