# MATLAB implementation of An accurate method to calculate the color difference in a single image [paper](https://scholar.google.com/citations?user=xxlAF58AAAAJ&hl=en#d=gs_md_cita-d&p=&u=%2Fcitations%3Fview_op%3Dview_citation%26hl%3Den%26user%3DxxlAF58AAAAJ%26citation_for_view%3DxxlAF58AAAAJ%3Au5HHmVD_uO8C%26tzom%3D480). 
<br/>
The problem of measuring the color difference in images have been an interesting topic for quite some time due to the contribution that colors give to the images' quality and characteristics. Many algorithms have been used in measuring the color difference between two images such as AE76 and AE94. However, measuring the color difference in a single image is a very important aspect for quite a number of applications such as indicating the quality of the dyes or production errors in monochromatic materials, matching paint colors to images, matching fabric colors, and many more. In this paper, we propose an accurate method to calculate the color difference in an image that represents a monochromatic object or substance with the same color level, or in other words, a single image. Luminance, Chrominance, and Hue “LCH” color space parameters are derived from Luminance and color opponent's channels green-red and blue-yellow “LAB” color space parameters, and difference of the single image is performed with the aid of the CIEDE2000 color difference formula. The proposed method has shown a significant improvement in terms of accuracy. The results of this method have proven that the proposed method is the most reliable and accurate among the existing methods
<br/>

## Algorithm
![algo](https://user-images.githubusercontent.com/30661597/47487556-7be06e80-d7f7-11e8-8c6b-bebefa3a0371.PNG)

## Some Results
![1](https://user-images.githubusercontent.com/30661597/47487554-7a16ab00-d7f7-11e8-8b47-d12d2cb12403.PNG)

## Files
`deltaE2000.m` is the file used to produce the results of our methodology <br/>
The other Files:  
`hsv.m` 
`lab.m`
`rgbintensity.m` are for Comparison with our method <br/>
