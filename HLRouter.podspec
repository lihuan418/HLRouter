

Pod::Spec.new do |s|
  s.name             = 'HLRouter'
  s.version          = '1.0.0'
  s.summary          = '路由模块'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '李欢' => 'lihuan418@163.com' }
  s.ios.deployment_target = '8.0'

  s.homepage         = 'https://github.com/lihuan418/HLRouter'
  s.source           = { :git => 'https://github.com/lihuan418/HLRouter.git', :tag => s.version.to_s }
  s.source_files = 'HLRouter/Classes/**/*'


end
