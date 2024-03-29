
Pod::Spec.new do |s| 

  s.name         = "UtilCore"
  s.version      = "1.1.4"
  s.summary      = " 工具库 "

  s.description  = <<-DESC
   工具库 
                   DESC

  s.homepage     = "https://github.com/zhtut/UtilCore.git"

  s.license        = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "zhtg" => "zhtg@icloud.com" }

  s.source       = { :git => "https://github.com/zhtut/UtilCore.git", :tag => "#{s.version}" }

  s.source_files  = "Sources/**/*.swift"

  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = '10.13'

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'ENABLE_MODULE_VERIFIER' => 'YES' }

end
