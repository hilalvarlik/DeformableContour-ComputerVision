# DeformableContour
## Tümör Tespiti
Görüntünün gradienti hesaplandığında en yüksek piksel değerleri olan yer contour olan yerdir.
![formul](https://user-images.githubusercontent.com/50299378/106662484-7fa4f300-65b3-11eb-84f4-849496563e93.JPG) <br/>
Yılan n tane noktadan oluşan kümedir. <br/>
Econt ve Ecurv sıfıra yakınsa Eimage yüksek gradient değerleri olan yerlere gider. Her nokta için 3
parametre vardır. <br/>
+ Ecount: Devamlılık sürekliliktir . Yılanın her bir noktasının arasındaki uzaklık olabildiğince az
olmalıdır. <br/>
+ Ecurv: Smooth olup olmadığıdır, bu noktaların olabildiği kadar düzgün olması gerekir. Smooth olması pi
noktası etrafında türev alınırsa 1.türev pi lerin birbirine göre nasıl değiştiğini verir 2.türevin ise 0
olması gerekir yani ivme olmamalı sabit hızda olmalıdır. <br/>
+ Eimage: Görüntü değeridir, gradient değerini hesaplandığında bir noktanın yüksek gradient değerine
sahip olması beklenir. Ne kadar yüksek olursa görüntü üzerindeki değerler o kadar negatif
olur.<br/>
Bu parametrelerin toplamının sıfıra yakın olması başarılı sonuç verir <br/>
---
Burada tespit için ilk başlangıç değerlerinin seçimi önemlidir. <br/>
`n = 500;  Xcenter =110;   Ycenter = 58;   r =10; mu = 2;` olacak şekilde seçilir.
