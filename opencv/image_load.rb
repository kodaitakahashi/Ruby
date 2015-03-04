require 'opencv'
include OpenCV


image = OpenCV::IplImage.load("numakuro.jpg")

window = GUI::Window.new('Display window')
window.show(image)
GUI::wait_key
