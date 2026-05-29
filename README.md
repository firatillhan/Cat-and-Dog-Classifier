---

# Cat and Dog Classifier

This is an image classification app I built while learning CoreML and Vision framework. I updated the original code and uploaded it to GitHub.

---

## Model

I trained the model myself using CreateML's Image Classifier feature. I dragged and dropped cat and dog photos I collected from the internet into CreateML to train it. Since the output type is Softmax, the confidence percentages of the two classes always add up to close to 100%.

---

## Features

- Pick a photo from the gallery
- Image classification using CoreML and Vision framework
- Display prediction result and confidence percentage

---

## Limitations

The model was trained only on cat and dog photos. Since it uses Softmax, it must always choose one of the two classes. If a photo other than a cat or dog is provided, the model will produce an incorrect prediction.

---

## Installation

1. Clone the repo
2. Open `Kedi ve Köpek.xcodeproj` in Xcode
3. Run

---

## Technologies Used

- Swift
- UIKit
- CoreML
- Vision
- CreateML

---

Beğendin mi?
