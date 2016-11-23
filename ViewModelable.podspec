Pod::Spec.new do |s|

  s.name         = "ViewModelable"
  s.version      = "0.4.1"
  s.summary      = "A lightweight Swift view model implementation with no dependencies."

  s.description  = <<-DESC
                   A lightweight Swift view model implementation with no external dependencies.
                   DESC

  s.homepage     = "http://github.com/Legoless/ViewModelable"
  s.license      = 'MIT'
  s.author       = { "Dal Rupnik" => "legoless@gmail.com" }
  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/Legoless/ViewModelable.git", :tag => s.version }

  s.source_files = 'ViewModelable/**/*.{swift}'
  s.requires_arc = true
end
