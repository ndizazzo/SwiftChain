Pod::Spec.new do |s|
  s.name         = "SwiftChain"
  s.version      = "1.0"
  s.summary      = "A basic implementation of a blockchain data structure, written purely in Swift."
  s.description  = <<-DESC
    The SwiftChain framework provides a Swift implementation of a rudimentary blockchain data structure.

    This framework is intended to be the smallest component of a larger blockchain application, and can be included in projects that add or provide other functionality such as: node/peer discovery, blockchain resolution, etc.
  DESC
  s.homepage     = ""
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Nick DiZazzo" => "nick@twg.io" }
  s.social_media_url   = ""
  s.ios.deployment_target = "10.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "3.0"
  s.tvos.deployment_target = "10.0"
  s.source       = { :git => ".git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
