Pod::Spec.new do |s|
  s.name     = 'PMAnimationLabelView_swift'
  s.version  = '1.0.2'
  s.license  = 'MIT'
  s.summary  = 'swift based animation label view'
  s.homepage = 'https://github.com/peromasamune/PMAnimationLabelView_swift'
  s.author   = { "Peromasamune" => "peromasamune00375421@gmail.com" }
  s.source   = { :git => "https://github.com/peromasamune/PMAnimationLabelView_swift.git", :tag => "#{s.version}" }
  s.platform = :ios
  s.source_files = 'PMAnimationLabelView/*.{h,m,swift}'
  s.framework = 'UIKit' , 'QuartzCore'
end
