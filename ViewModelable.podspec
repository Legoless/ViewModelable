Pod::Spec.new do |s|

  s.name         = "ViewModelable"
  s.version      = "0.1.0"
  s.summary      = "A basic view model implementation."

  s.description  = <<-DESC
                   A simple, easy to use view model implementation.
                   DESC

  s.homepage     = "http://github.com/Legoless/ViewModelable"
  s.license      = 'MIT'
  s.author       = { "Dal Rupnik" => "legoless@gmail.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/Legoless/ViewModelable.git", :tag => s.version }

  s.source_files = 'ViewModelable/**/*.{swift}'
  s.requires_arc = true
end
