
Pod::Spec.new do |s| 

  s.name         = "SSCommon"
  s.version      = "1.0.1"
  s.summary      = " 工具库 "

  s.description  = <<-DESC
   工具库 
                   DESC

  s.homepage     = "https://github.com/zhtut/SSCommon.git"

  s.license        = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "zhtg" => "zhtg@icloud.com" }

  s.source       = { :git => "https://github.com/zhtut/SSCommon.git", :tag => "#{s.version}" }

  s.source_files  = "Sources/**/*.swift"

  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = '10.13'

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

end
