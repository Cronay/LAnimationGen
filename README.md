LAnimationGen
=============

A simple command line tool it easier to access your [Lottie](https://github.com/airbnb/lottie-ios) Animations within your Swift code!

Motivation
----------

Lottie animation are used by placing a JSON file describing them within your Xcode project and then referenced like so:

```swift
let animation = Animation.named("my_animation")
```

This works nice but is prone to errors due to typos which aren't catched by the compiler. With a typo the `animation` is nil and nothing is shown by an `AnimationView`. To circumvent this problem one could create a class, struct or enum with static constants such as:

```swift
enum MyAnimations {
    static let myAnimation = Animation.named("my_animation")
    static let anotherAnimation = Animation.named("another_animation")
    ...
}
```
Now we can reference an animation like so:

```swift
let animation = MyAnimations.myAnimation
```

That's nice but this enum needs to be adjusted every time a file is added or removed.

This is were *LAnimationGen* comes in! It generates this these static constants for you so they can be referenced easily and without the risk of making typos within your code.

Installation
------------
### Homebrew (recommended)

```console
$ brew tap cronay/projects
$ brew install LAnimationGen
```

### Make

```console
$ git clone https://github.com/Cronay/LAnimationGen.git
$ cd LAnimationGen
$ make install
```

Usage
-----
LAnimationGen can be used from the command line or can be integrated into the Xcode build phases of your project. With the latter approach the generated file stays up to date.

### Command Line
```console
$ lanimationgen --input <path/to/directory/with/lottie/file> --output <path/to/some/folder>
```
The input path will be scanned for JSON files and a file called `LAnimation.swift` will be placed in the output path. You might want to make sure that the output directory does exist before running the tool.

### Integration into Xcode project
It is recommended to run this tool while building your project, so the generated class is in sync with the latest set of Lottie animations. To do so go to your project's Build Phases tab and add another Run Script phase. Make sure to run this phase before the Compile Resources phase. Paste this in there and replace the input and output path: 
```bash
if which lanimationgen >/dev/null; then
    lanimationgen --input "$SOURCE_ROOT/path" --output "$SOURCE_ROOT/path"
else
    echo "warning: LAnimationGen not installed, download from https://github.com/Cronay/LAnimationGen"
fi
```
When running the script for the first time you might need to add the generated file `LAnimation.swift` to the project. After that everything should be set up properly.

License
-------
```
MIT License

Copyright (c) 2020 Cronay

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
