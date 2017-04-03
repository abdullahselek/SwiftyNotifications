Pod::Spec.new do |s|

    s.name                  = 'SwiftyNotifications'
    s.version               = '1.0'
    s.summary               = 'Highly configurable iOS UIView for presenting notifications that does not block the UI.'
    s.homepage              = 'https://github.com/abdullahselek/SwiftyNotifications'
    s.license               = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author                = {
        'Abdullah Selek' => 'abdullahselek@yahoo.com'
    }
    s.source                = {
        :git => 'https://github.com/abdullahselek/SwiftyNotifications.git',
        :tag => s.version.to_s
    }
    s.ios.deployment_target = '9.0'
    s.source_files          = 'SwiftyNotifications/*.swift'
    s.requires_arc          = true

end