Pod::Spec.new do |s|
  s.name = 'Curator'
  s.summary = 'Curator is a lightweight key-value file manager written in Swift.'
  s.version = '1.0'
  s.authors = { 'Yanzhi Wang' => 'yzwang.nj@gmail.com' }
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage = "https://github.com/puttin/Curator"
  s.source = { :git => 'https://github.com/puttin/Curator.git', :tag => s.version }
  
  s.ios.deployment_target = '8.0'
  
  s.ios.source_files = 'Curator/*.swift'
  
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
